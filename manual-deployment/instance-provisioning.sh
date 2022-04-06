#!/usr/bin/env bash
set -euo pipefail

# TWEAK SETTINGS
NODES=42
REPO=https://github.com/dyne/restroom-vmlet-template
CONTRACTS=saved_files.sh

# UTILITIES
BASEPATH=$(pwd)
# HOST=$(hostname -I)
# changed to (hostname) cause the current staging uses a shared ip
HOST=$(hostname -I)

# DEPENDENCIES
command -v python || (sudo apt install -y python)
command -v git || (sudo apt install -y git)
command -v yarn || (npm install --global yarn)
command -v npx || (curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && sudo apt-get install -y nodejs)
command -v make || (sudo apt install -y build-essential)
command -v pm2 || (yarn global add pm2)
dpkg -l libczmq-dev &> /dev/null || (sudo apt install -y libczmq-dev)
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
link_build PeculiarVentures/pkcs11js

parallel_job() {
  local i=$1
  NODE=restroom-mw-$i
  WD=$BASEPATH/vmlets/$NODE

  if ! test -d $WD; then
    npx degit $REPO $WD
    cd $WD
    yarn link @bitauth/libauth
    yarn link sqlite3
    yarn link protobufjs
    yarn link pkcs11js
    yarn link secp256k1
    yarn add zeromq@5 --zmq-external
    yarn

  fi
  cd $WD
  if ! test -d contracts; then
    mkdir contracts
  fi
  bash $BASEPATH/$CONTRACTS
  echo "CUSTOM_404_MESSAGE=nothing to see here
  ZENCODE_DIR="$(pwd)/contracts"
  FILES_DIR=$(pwd)
  CHAIN_EXT=chain
  # OPENAPI=true
  HOST=$HOST
  PRIVATE_ZENCODE_DIR="$BASEPATH/private_zencode_dir"
  YML_EXT=yml"> .env

  pm2 delete $NODE || true
  pm2 start yarn --update-env --name $NODE --time -- start
}

for i in $(seq $NODES); do
  parallel_job $i &
done
