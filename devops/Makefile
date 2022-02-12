
REGION ?= eu-west

inventory:
	./linode-swarm.sh inventory

all-up: inventory
	./linode-swarm.sh all-up

all-down: inventory
	./linode-swarm.sh all-down

one-up:
	./linode-swarm.sh one-up ${REGION}

one-down:
	./linode-swarm.sh one-down ${REGION}

ansible/install: inventory
	./linode-swarm.sh install.yaml

ssh:
	./linode-swarm.sh ssh
