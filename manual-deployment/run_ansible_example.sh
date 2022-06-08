#!/usr/bin/env bash
ansible-playbook instance-provisioning.yml -i hosts.toml -e '{"hostname": "zenswarm.zenroom.org", "announce_url": "https://apiroom.net/api/dyneorg/zenswarm-server-add-identity-dev", "deannounce_url": "https://apiroom.net/api/dyneorg/zenswarm-issuer-remove-identity-dev", "nodes": 7 }'
