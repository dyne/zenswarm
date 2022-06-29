##@ General
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' Makefile

image-build: linode-token := $(shell awk '/token/ {print $$3}' ${HOME}/.config/linode-cli)
image-build: tmp := $(shell mktemp)
image-build: ## build the zenswarm golden image on cloud
	@sed "s/linode_token=\"\"/linode_token=\"${linode-token}\"/g" packer/linode.pkr.hcl > ${tmp}.pkr.hcl
	-cd packer && packer build ${tmp}.pkr.hcl
	rm -f ${tmp} ${tmp}.pkr.hcl
