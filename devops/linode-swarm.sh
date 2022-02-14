#!/bin/bash

info() { echo >&2 "$1"; }

# env defined by called makefile:
# group=consensusroom
# nodetype=g6-nanode-1
# rootpass=`openssl rand -base64 32`
# sshkey := ${HOME}/sshkey-${group}

sshkey=`pwd`/sshkey-${group}
if ! [ -r ${sshkey} ]; then ssh-keygen -t ed25519 -f ${sshkey} -q -N ''; fi
#curl -sL https://api.linode.com/v4/regions | jq . | awk '/id.:/ {print $2}' | xargs

# regions=(ap-west ca-central ap-southeast us-central us-west us-southeast us-east eu-west ap-south eu-central ap-northeast)
# only 5
regions=(ca-central us-west us-east eu-central ap-west)

linode-up() { linode-cli linodes create --root_pass ${rootpass} --type ${nodetype} --group ${group} --label ${group}-${reg} --region ${reg} --authorized_keys "$(cat ${sshkey}.pub)";}
linode-up-dry() { info "linode-cli linodes create --root_pass ${rootpass} --type ${nodetype} --group ${group} --label ${group}-${reg} --region ${reg} --authorized_keys \"`cat ${sshkey}.pub`\"" ; }

# linode-cli linodes list format
#   2    4       6        8      10      12        14
# │ id │ label │ region │ type │ image │ status  │ ipv4 │
cmd="$1"
case $cmd in
    one-up)
	reg=${2:-eu-west}
	linode-up
	;;
    ip)
	reg=${2:-eu-west}
	ids=(`linode-cli linodes list | awk "/${group}/"' {print $6","$14}'`)
	for i in ${ids[@]}; do
	    f=(${i//,/ })
	    if [ "$reg" = "${f[0]}" ]; then
		echo ${f[1]}
		exit 0
	    fi
	done
	;;
    id)
	reg=${2:-eu-west}
	ids=(`linode-cli linodes list | awk "/${group}/"' {print $2","$6","$14}'`)
	for i in ${ids[@]}; do
	    f=(${i//,/ })
	    if [ "$reg" = "${f[1]}" ]; then
		echo ${f[0]}
		exit 0
	    fi
	done
	;;

    announce)
	info "Announce all nodes"
	ids=(`linode-cli linodes list | awk "/${group}/"' {print $14}'`)
	for i in ${ids[@]}; do
	    curl -X 'POST' "http://${i}:3300/api/consensusroom-announce.chain"
	done
	;;

    reboot)
	info "Reboot all nodes"
	ids=(`linode-cli linodes list | awk "/${group}/"' {print $14}'`)
	for i in ${ids[@]}; do
	    info "reboot ${i}"
	    ssh -i ${sshkey} root@${i} -c 'init 6'
	done
	;;

    all-up)
	for reg in ${regions[@]}; do
	    linode-up
	done
	;;

    all-down)
	ids=(`linode-cli linodes list | awk ''"/${group}/"' {print $2","$4","$14}'`)
	for i in ${ids[@]}; do
	    f=(${i//,/ })
	    info "delete ${f[1]} (${f[2]})"
	    linode-cli linodes delete ${f[0]};
	done
	;;
    inventory)
	ips=(`linode-cli linodes list | awk ''"/${group}/"' {print $14}'`)
	rm -f hosts.toml
	echo "[$group]" | tee -a hosts.toml
	if [ ${#ips} = 0 ]; then 
	    info "Zero nodes found."
	    exit 1
	fi
	for i in ${ips[@]}; do
	    echo "$i" | tee -a hosts.toml
	done
	;;

    install|install.yaml)
	shift 1
	ANSIBLE_HOST_KEY_CHECKING=False \
        ansible-playbook install.yaml \
	--private-key ${sshkey} --inventory hosts.toml $*
	;;

    deploy|deploy.yaml)
	shift 1
	ANSIBLE_HOST_KEY_CHECKING=False \
        ansible-playbook deploy.yaml \
	--private-key ${sshkey} --inventory hosts.toml $*
	;;
    *)
	info "usage: $0 [ one-up/down | all-up/down | inventory ]"
	;;
esac
