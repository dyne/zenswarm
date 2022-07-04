R ?= $(shell pwd)
REGION ?= eu-central
IP ?= $(shell linode-cli --text --no-header --format region,ipv4 linodes list | awk '/${REGION}/{print $$2}')
IMAGE ?= $(shell linode-cli  --text --no-header --format id,label images list | awk '/ zenswarm / {print $$1}')
rootpass := $(shell openssl rand -base64 32)
nodetype := g6-nanode-1
sshkey := ${R}/sshkey
# regions=(ap-west ca-central ap-southeast us-central us-west us-southeast us-east eu-west ap-south eu-central ap-northeast)
regions := ca-central us-west us-east eu-central ap-west ap-southeast
# only 6
export

ANSIPLAY = ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory hosts.toml --ssh-common-args '-o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes' --private-key ${sshkey} "ansible/$(1)"

LINCREATE = xargs -I {} linode-cli linodes create --root_pass ${rootpass} --type ${nodetype} --group zenswarm --image $(1) --label zenswarm-"{}" --region "{}" --authorized_keys "$(shell cat ${sshkey}.pub)"
##@ General
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' Makefile

##@ Image management
ssh-keygen: ## generate a dedicated ssh keypair here
	$(if $(wildcard ${sshkey}),,\
		$(info Generating ssh keypair) \
		ssh-keygen -t ed25519 -f ${sshkey} -q -N '')

one-up: ssh-keygen ## create one oracle in REGION (eu-central is default)
	$(if ${IMAGE}, \
		$(info Zenswarm image found: ${IMAGE}), \
		$(error Zenswarm image not found, use image-build first))
	$(info Creating one node in region ${REGION})
	@echo ${REGION} | $(call LINCREATE,${IMAGE})
	@make -s ssh-cleanup
	@./scripts/wait-running.sh


image-build: linode-token := $(shell awk '/token/ {print $$3}' ${HOME}/.config/linode-cli)
image-build: tmp := $(shell mktemp)
image-build: ## build the zenswarm golden image on cloud
	@sed "s/linode_token=\"\"/linode_token=\"${linode-token}\"/g" packer/linode.pkr.hcl > ${tmp}.pkr.hcl
	-cd packer && packer build ${tmp}.pkr.hcl
	rm -f ${tmp} ${tmp}.pkr.hcl



ssh-cleanup: ## clean all saved ssh fingerprints of known oracles
	@make -s list-ips | xargs -I {} \
		ssh-keygen -q -f "${HOME}/.ssh/known_hosts" -R "{}"

ssh: login ?= root
ssh: ## log into a node in REGION via ssh (eu-central is default)
	$(info Logging into node via ssh on region ${REGION})
	ssh -l ${login} -i ${sshkey} \
	 -o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes ${IP}

##@ Server config
setup-tls: ## Install TLS certificates
	$(info Start TLS certificate creation)
	$(call ANSIPLAY,acme-certificate.yml)

init: ## Init instances
	$(info Generate .env and keys)
	$(call ANSIPLAY,init-instances.yml)

start: ## Start instances
	$(info Starting instances...)
	$(call ANSIPLAY,start-instances.yml)

update: ## Update instances
	$(info Updating instances...)
	$(call ANSIPLAY,update-instances.yml)

kill: ## Kill instances
	$(info Killing instances...)
	$(call ANSIPLAY,kill-instances.yml)
