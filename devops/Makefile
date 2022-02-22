R ?= $(shell pwd)
REGION ?= eu-west
rootpass := $(shell openssl rand -base64 32)
nodetype := g6-nanode-1
group := consensusroom
sshkey := ${R}/sshkey-${group}
export

##@ General
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' Makefile

inventory: ## update and show list of active nodes
	@./linode-swarm.sh inventory

regions: ## list available regions
	@curl -sL https://api.linode.com/v4/regions \
	| jq . | awk '/id.:/ {print $$2} /country.:/ {print $$2"\n"}'

ssh-keygen: ## generate a dedicated ssh keypair here
	$(if $(wildcard ${sshkey}),,\
		$(info Generating ssh keypair) \
		ssh-keygen -t ed25519 -f ${sshkey} -q -N '')

##@ Node lifecycle

all-up: ## create 11 active nodes, one for each linode region
	$(info Creating active nodes in all available regions)
	@./linode-swarm.sh all-up

all-down: inventory ## destroy all active nodes
	$(info Destroying existing nodes in all regions)
	@./linode-swarm.sh all-down

one-up: ## create one active node in REGION (eu-west is default)
	$(info Creating one node in region ${REGION})
	@./linode-swarm.sh $(shell ./linode-swarm.sh id) ${REGION}

one-down: ## destroy one active node in REGION (eu-west is default)
	$(info Destroying one node in region ${REGION})
	@linode-cli linodes delete $(shell linode-swarm.sh id) ${REGION} 

##@ Node operations
install: inventory ssh-keygen ## install the zencode api server on all available nodes
	$(info Installing all nodes)
	ANSIBLE_HOST_KEY_CHECKING=False \
        ansible-playbook ${MAKECMDGOALS}.yaml \
	--ssh-common-args '-o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes' \
	--private-key ${sshkey} --inventory hosts.toml $*

deploy: inventory ssh-keygen ## install the zencode api server on all available nodes
	$(info Installing all nodes)
	ANSIBLE_HOST_KEY_CHECKING=False \
        ansible-playbook ${MAKECMDGOALS}.yaml \
	--ssh-common-args '-o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes' \
	--private-key ${sshkey} --inventory hosts.toml $*

announce: inventory
	./linode-swarm.sh announce

ssh: ssh-login ?= app
ssh: ssh-keygen ## log into a node in REGION via ssh (eu-west is default)
	$(info Logging into node via ssh on region ${REGION})
	ssh -l ${ssh-login} -i ${sshkey} $(shell ./linode-swarm.sh ip)

uptime: inventory ## show uptime of all running nodes
	$(info Showing uptime for all running nodes)
	ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook ${MAKECMDGOALS}.yaml \
	--ssh-common-args '-o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes' \
	--private-key ${sshkey} --inventory hosts.toml

reboot: inventory
	ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook ${MAKECMDGOALS}.yaml \
	--ssh-common-args '-o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes' \
	--private-key ${sshkey} --inventory hosts.toml

restart: inventory
	ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook ${MAKECMDGOALS}.yaml \
	--ssh-common-args '-o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes' \
	--private-key ${sshkey} --inventory hosts.toml
