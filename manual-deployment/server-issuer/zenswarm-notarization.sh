#!/usr/bin/env bash 

echo "\\nMake sure you have node 16, the version you have is\\n" 
node -v

# Installing restroom
npx create-restroom --all restroom-mw

# setup docker
cd ./restroom-mw

echo 'CUSTOM_404_MESSAGE=nothing to see here
HTTP_PORT=3300
HTTPS_PORT=3301
FILES_DIR=./contracts
CHAIN_EXT=chain
# OPENAPI=true
YML_EXT=yml' > .env

echo "


Given I have a 'string dictionary' named 'post'
Given I have a 'string' named 'endpoint'
Given I have a 'string array' named 'result' in 'params'

# Given I have a  'result' in 'params'

#Given I have a 'hex' named 'hash' in 'result'

When I create the copy of 'hash' from dictionary 'result'
When I rename the 'copy' to 'hash'

When I create the 'hex array' named 'params'
When I insert 'hash' in 'params' 
When I insert false '' in 'params'

When I insert 'params' in 'post'

Then print the 'post'
Then print the 'endpoint'
"> ./contracts/ethNotarization-0-newhead.zen
echo ✔ Imported ethNotarization-0-newhead.zen

echo "{\"post\":{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBlockByHash\",\"id\":1},\"true\":true}" > ./contracts/ethNotarization-0-newhead.keys
echo ✔ Imported ethNotarization-0-newhead.keys

echo "

# simulate a call by the callback from ethereum subscription to new heads

# curl --location --request POST 'http://test.fabchain.net:8545' --header 'Content-Type: application/json' --data-raw \
# '{ "jsonrpc":"2.0", "method":"eth_getBlockByHash", "params":[ "HASH", false ], "id":1 }'

# Always use 'Rule caller restroom-mw' when using Restroom
Rule caller restroom-mw

Given I connect to 'endpoint' and pass it the content of 'post' and save the output into 'output'
Given I have a 'string' named 'endpoint'
Given I have a 'string dictionary' named 'post'
Given I have a 'string dictionary' named 'result' in 'output'
When I rename the 'result' to 'params'
then print the 'params'



"> ./contracts/ethNotarization-1-newhead.zen
echo ✔ Imported ethNotarization-1-newhead.zen


echo "
Given I have a 'hex dictionary' named 'result' in 'params'
# and I have a 'number' named 'system_timestamp'
When I create the 'hex dictionary' named 'newblock'
When I move 'hash' from 'result' to 'newblock'
When I move 'number' from 'result' to 'newblock'
When I move 'parentHash' from 'result' to 'newblock'
When I move 'timestamp' from 'result' to 'newblock'
# When I insert 'system_timestamp' in 'newblock'

When I create the mpack of 'newblock'
When I rename the 'mpack' to 'newblock-mpack'
Then print the 'newblock'
Then print the 'newblock-mpack'

"> ./contracts/ethNotarization-2-filter-newhead.zen
echo ✔ Imported ethNotarization-2-filter-newhead.zen

echo "{\"fabchain\":\"http://test.fabchain.net:8545\",\"myTag\":\"239fb776c62bb583dd6464804cd6183945a4fa5722090b23a7281dcafc8b436b\"}" > ./contracts/Ethereum-retrieve-A.keys
echo ✔ Imported Ethereum-retrieve-A.keys

echo "
Rule unknown ignore
Scenario ethereum: test store
Given I have the 'keyring'
Given I have a ethereum endpoint named 'fabchain'
Given I have a 'ethereum address' named 'storage contract'
Given I have a 'ethereum nonce'
Given I read the ethereum nonce for 'my_address'
and a 'gas price'
and a 'gas limit'
Given I have a 'base64' named 'newblock-mpack'

# Given I read the # ethereum suggested gas price
When I create the ethereum transaction to 'storage contract'
When I use the ethereum transaction to store 'newblock-mpack'

When I create the signed ethereum transaction for chain 'fabt'
Then print the 'signed ethereum transaction'
Then I ask ethereum to broadcast the 'signed_ethereum_transaction' and save the transaction id in 'txid'
Then print data

"> ./contracts/ethNotarization-3-ethereum-store.zen
echo ✔ Imported ethNotarization-3-ethereum-store.zen

echo "{\"keyring\":{\"ethereum\":\"2bb7018d08990874cea523d52642ecd470021a4e7d8b93553bbfcd2343ee8b37\"},\"my_address\":\"28c44EeA27c304bE7416a220515A823E29a0Fb83\",\"fabchain\":\"http://test.fabchain.net:8545\",\"gas limit\":\"100000\",\"gas price\":\"1000000000\",\"gwei value\":\"0\",\"storage_contract\":\"1b620cA5172A8D6A64798FcA2ee690066F7A7816\"}" > ./contracts/ethNotarization-3-ethereum-store.keys
echo ✔ Imported ethNotarization-3-ethereum-store.keys

echo "
Rule caller restroom-mw

Given I fetch the local timestamp and store it into 'myTimestamp'


Given I have a 'string' named 'myTimestamp'

Given I have a 'string' named 'block_id'
Given I have a 'number' named 'block_num'
Given I have a 'string' named 'previous_block_id'

Given I have a 'string' named 'endpoint'


When I create the 'string dictionary'
When I rename the 'string dictionary' to 'sawroomNewBlock'

When I insert 'block_id' in 'sawroomNewBlock'
When I insert 'previous_block_id' in 'sawroomNewBlock'
When I insert 'block_num' in 'sawroomNewBlock'
When I insert 'myTimestamp' in 'sawroomNewBlock'


When I create the copy of 'block_id' from dictionary 'sawroomNewBlock'
When I rename the 'copy' to 'block_id'
When I write string 'blocks/' in 'blocks'
When I append 'blocks' to 'endpoint'
When I append 'block_id' to 'endpoint'

then print the 'endpoint'
then print the 'sawroomNewBlock'
# Then print the 'url'
"> ./contracts/sawroom-notarization-0.zen
echo ✔ Imported sawroom-notarization-0.zen


echo "
Rule caller restroom-mw

Given that I have an endpoint named 'endpoint' 

Given I have a 'string dictionary' named 'sawroomNewBlock'

Given I have a 'string' named 'endpoint'

Given I connect to 'endpoint' and save the output into 'dataFromEndpoint'

Given I have a 'string dictionary' named 'dataFromEndpoint'

Then print the 'dataFromEndpoint'



"> ./contracts/sawroom-notarization-1.zen
echo ✔ Imported sawroom-notarization-1.zen


echo "
Given I have a 'string dictionary' named 'data' inside 'dataFromEndpoint'

then print data
"> ./contracts/sawroom-notarization-2.zen
echo ✔ Imported sawroom-notarization-2.zen



echo "
zenchain: 1.0
start: id_0
blocks:
  id_0:
    zenFile: ethNotarization-0-newhead.zen
    keysFile: ethNotarization-0-newhead.keys
    next: id_1
  id_1:
    zenFile: ethNotarization-1-newhead.zen
    next: id_2
  id_2:
    zenFile: ethNotarization-2-filter-newhead.zen
    keysFile: Ethereum-retrieve-A.keys
    next: id_3
  id_3:
    zenFile: ethNotarization-3-ethereum-store.zen
    keysFile: ethNotarization-3-ethereum-store.keys

"> ./contracts/ethereum-notarization.yml
echo ✔ Imported ethereum-notarization.yml
echo "
zenchain: 1.0
start: id_0
blocks:
  id_0:
    zenFile: sawroom-notarization-0.zen
    next: id_1
  id_1:
    zenFile: sawroom-notarization-1.zen
    next: id_2
  id_2:
    zenFile: sawroom-notarization-2.zen

"> ./contracts/sawroom-notarization.yml
echo ✔ Imported sawroom-notarization.yml

# instructions 
echo \\nTo launch restroom-mw, type\\n:

red=`tput setaf 1`
echo "${red}cd restroom-mw"
echo "${red}yarn start"