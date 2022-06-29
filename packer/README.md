# Order of scripts to generate the golden image

- Cloud command setup on Linode: [packer build](linode.pkr.hcl)
- Debian install via ansible on linode: [ansible provisioning](install-linode.yaml)
- Start script at every boot: [shell boot](start.sh)
