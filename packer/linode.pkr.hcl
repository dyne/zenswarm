locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "linode" "zenswarm" {
  image             = "linode/debian11"
  image_description = "Zenswarm golden image based on Devuan"
  image_label       = "zenswarm"
  instance_label    = "zenswarm-temporary-image-${local.timestamp}"
  instance_type     = "g6-nanode-1"
  linode_token=""
  region            = "eu-central"
  ssh_username      = "root"
}

variable "ansible_host" { default = "zenswarm" }

build {
  sources = ["source.linode.zenswarm"]
  provisioner "ansible" { playbook_file = "./install-linode.yaml" }
}
