#!/usr/bin/env bash
set -euo pipefail

# TWEAK SETTINGS
NODES=10
REPO=https://github.com/dyne/restroom-template-minimal
CONTRACTS=saved_files.sh

# UTILITIES
BASEPATH=$(pwd)
HOST=$(hostname -I)
PORTS=()

# DEPENDENCIES
command -v python || (apt install -y python)
command -v git || (apt install -y git)
command -v yarn || (npm install --global yarn)
command -v npx || (curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs)
command -v make || (apt install -y build-essential)
command -v pm2 || (yarn global add pm2)
dpkg -l libczmq-dev &> /dev/null || (apt install -y libczmq-dev)
npm install -g node-gyp-cache
npm config set node_gyp node-gyp-cache

link_build() {
  if ! test -d $(basename $1); then
    git clone --recursive https://github.com/$1 && cd $(basename $1)
    yarn install
    yarn link
    cd ..
  fi
} 

link_build bitauth/libauth
link_build cryptocoinjs/secp256k1-node
link_build protobufjs/protobuf.js
link_build mapbox/node-sqlite3

# PORTS
get_available_ports() {
  local PORTS=()
  read min MAX < /proc/sys/net/ipv4/ip_local_port_range
  PORTS_NUM=$NODES*2

  for _p in $(seq $min $MAX); do
    ss -lpn | grep -q ":$_p"
    if [[ $? -eq 0 ]]; then
      continue
    fi
    PORTS+=($_p)
    PORTS_NUM=$PORTS_NUM-1
    if [[ $PORTS_NUM -lt 1 ]]; then
      break;
    fi
  done
 
  echo ${PORTS[@]}
}

PORTS=( $(get_available_ports) )

parallel_job() {
  local i=$1
  NODE=restroom-mw-$i
  WD=$BASEPATH/tmp/$NODE
  HTTP=${PORTS[$i*2-2]}
  HTTPS=${PORTS[$i*2-1]}

  if ! test -d $WD; then
    npx degit $REPO $WD
  fi
  cd $WD
  if ! test -d contracts; then
    mkdir contracts
  fi
  bash $BASEPATH/$CONTRACTS
  yarn link @bitauth/libauth
  yarn link sqlite3
  yarn link protobufjs
  yarn link secp256k1
  yarn add zeromq@5 --zmq-external
  yarn

  echo "{\"identity\":{\"uid\":\"random\",\"ip\":\"$HOST\",\"baseUrl\":\"http://$HOST\",\"port_http\":\"$HTTP\",\"port_https\":\"$HTTPS\",\"public_key\":\"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=\",\"version\":\"2\",\"announceAPI\":\"/api/consensusroom-announce\",\"get-6-timestampsAPI\":\"/api/consensusroom-get-6-timestamps\",\"timestampAPI\":\"/api/consensusroom-get-timestamp\",\"tracker\":\"https://apiroom.net/\"}}"

> ./contracts/identity.keys

echo ✔ Imported identity.keys
  pm2 start yarn --name $NODE -- start
}

for i in $(seq $NODES); do
  parallel_job $i &
done

