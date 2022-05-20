#!/usr/bin/env bash
set -euo pipefail

# TWEAK SETTINGS
${COUNTRY:="NONE"}
${NODES:=6}
${REPO:=https://github.com/dyne/restroom-vmlet-template}
${CONTRACTS:=saved_files.sh}

# UTILITIES
BASEPATH=$(pwd)
# HOST=$(hostname -I)
# changed to (hostname) cause the current staging uses a shared ip
HOST=$(hostname)

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

parallel_job() {
  local i=$2
  NODE=restroom-mw-$i
  WD=$BASEPATH/vmlets/$NODE

  if ! test -d $WD; then
    npx degit $REPO $WD
    cd $WD
    sed -ie "s/restroom-vmlet-template/${NODE}/g" package.json
    yarn

  fi
  cd $WD
  if ! test -d contracts; then
    mkdir contracts
  fi
  SUBSCRIPTIONS="`echo "$1" | cut -d' ' -f 1`"
  L0_DEST="`echo "$1" | cut -d' ' -f 2`"

  bash $BASEPATH/$CONTRACTS
  echo "CUSTOM_404_MESSAGE=nothing to see here
  ZENCODE_DIR=\"$(pwd)/contracts\"
  FILES_DIR=$(pwd)
  CHAIN_EXT=chain
  # OPENAPI=true
  COUNTRY=\"$COUNTRY\"
  HOST=\"$HOST\"
  PRIVATE_ZENCODE_DIR=\"$BASEPATH/private-contracts\"
  SUBSCRIPTIONS="$SUBSCRIPTIONS"
  L0_DEST="$L0_DEST"
  YML_EXT=yml"> .env

  pm2 delete $NODE || true
  pm2 start yarn --update-env --name $NODE --time -- start
}

pm2 kill
rm -f "~/.pm2/logs/restroom-mw-*"

[ -f "./subscriptions.csv" ] || echo "No subscriptions.csv file"
i=0
IFS=$'\n'       # make newlines the only separator
for subscription in $(cat ./subscriptions.csv)
do
  echo $i
  parallel_job "$subscription" $i
  i=$(($i + 1))
done
# Note: IFS needs to be reset to default!

i=$(($i + 1))
for j in $(seq $i $NODES); do
  echo $j
  parallel_job "" $j
done
