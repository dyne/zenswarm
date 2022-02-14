#!/bin/sh

info() { echo >&2 "$1"; }

info '#'
info "Installing restroom"
info "Node version: `node -v`"
info '#'

npx --yes degit dyne/restroom-template-minimal restroom-mw --force

cd ./restroom-mw

# TO BE IMPLEMENTED
# - get the hostname
# - create string "baserUrl": "hostname:3300"
# - generate keypair
# - create string "uid": "random"
# - insert it in mySelf.keys, based on: 

cat <<EOF | tee .env
ZENCODE_DIR=./zencode
CUSTOM_404_MESSAGE=nothing to see here
HTTP_PORT=3300
HTTPS_PORT=3301
EOF

mkdir -p zencode

yarn 

info "#"
info "Restroom-mw Installation completed."
info "#"
