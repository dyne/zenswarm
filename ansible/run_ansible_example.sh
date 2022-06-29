#!/usr/bin/env bash
# ansible-playbook instance-provisioning.yml -i hosts.toml -e '{ "announce_url": "https://apiroom.net/api/dyneorg/zenswarm-server-add-identity-dev", "deannounce_url": "https://apiroom.net/api/dyneorg/zenswarm-issuer-remove-identity-dev" }'
ansible-playbook instances-provisioning.yml -i hosts.toml -e '{ "announce_url": "http://did.dyne.org:12000/api/W3C-DID-controller-create-oracle-DID.chain", "deannounce_url": "http://did.dyne.org:12000/api/W3C-DID-controller-remove-oracle" }'
