echo "
Rule caller restroom-mw

Given I have a 'string' named 'add-identity'
Given I have a 'string dictionary' named 'post'
# Given I have a 'string dictionary' named 'output'
Given I have a 'string dictionary' named 'output'
Given I connect to 'add-identity' and pass it the content of 'post' and save the output into 'output'


Then print the 'output'



"> ./contracts/consensusroom-announce.zen
echo ✔ Imported consensusroom-announce.zen

echo "{}" > ./contracts/consensusroom-announce.keys
echo ✔ Imported consensusroom-announce.keys





echo "

Scenario 'ecdh': Create the keypair
Scenario 'ethereum': Create the keypair
Scenario 'reflow': Create the keypair
Scenario 'schnorr': Create the keypair

Given I have the 'keyring'
When I create the ecdh public key
When I create the reflow public key
When I create the schnorr public key

When I create the bitcoin address
When I create the ethereum address

Then print the 'ecdh public key'
Then print the 'reflow public key'
Then print the 'schnorr public key'

Then print the 'bitcoin address'
Then print the 'ethereum address'

"> ./contracts/consensusroom-generate-all-public-keys.zen
echo ✔ Imported consensusroom-generate-all-public-keys.zen

echo "
Rule caller restroom-mw
Scenario 'ecdh': verifies the signature from Apiroom 
Given I have a 'string dictionary' named 'updateInfo'
Given I have a 'string dictionary' named 'update' inside 'updateInfo'
Given I have a 'base64 dictionary' named 'update.signature' inside 'updateInfo'
# Given I have a 'string' named 'myFile' inside 'update'
Given I have a 'string' named 'myFolder' 

# Given I have a 'signature' named 'update.signature' 
Given I have a 'ecdh public key' from 'Apiroom' 

When I verify the 'update' has a signature in 'update.signature' by 'Apiroom' 

When I create the copy of 'myFile' from dictionary 'update'
When I rename the 'copy' to 'myFile'

Then print the string 'Zenroom verified the Apiroom signature are all correct!' 
Then print the 'myFile'
Then print the 'myFolder'

Then I download the 'myFile' and extract it into 'myFolder'
"> ./contracts/consensusroom-update.zen
echo ✔ Imported consensusroom-update.zen

echo "{\"Apiroom\":{\"ecdh_public_key\":\"BPMbqmvEwUJsB6MmrswxKxza5+Lt82X20mAjcmknT7E7RysW6fACs/L3sXEOEh8qYxHKNAvcBCAetcIEuIEUVC4=\"},\"myFolder\":\"./contracts\"}" > ./contracts/consensusroom-update.keys
echo ✔ Imported consensusroom-update.keys

echo "
Rule caller restroom-mw
Given I have a 'string' named 'myTimestamp'
Given I fetch the local timestamp and store it into 'myTimestamp'
Then print 'myTimestamp'
"> ./contracts/consensusroom-get-timestamp.zen
echo ✔ Imported consensusroom-get-timestamp.zen


echo "
Rule unknown ignore
Given I connect to 'endpoint' and pass it the content of 'myDataToPOST' and save the output into 'dataFromEndpoint'
Given I have a 'string dictionary' named 'dataFromEndpoint'
Then print the 'dataFromEndpoint'
"> ./contracts/consensusroom-http-post.zen
echo ✔ Imported consensusroom-http-post.zen

echo "
Given nothing
Then print the string 'I am alive!'
"> ./contracts/consensusroom-ping.zen
echo ✔ Imported consensusroom-ping.zen

echo "
ledgers:
  ping:
    interval: 300
    contract: consensusroom-ping
"> ./L1.yaml
echo ✔ Imported L1.yaml


echo "
Rule caller restroom-mw
Given I connect to 'endpoint' and pass it the content of 'post' and save the output into 'output'
Given I have a 'string dictionary' named 'output'
Then print the 'output'
"> ./contracts/consensusroom-http-post.zen
echo ✔ Imported onsensusroom-http-post.zen


echo "
Scenario 'ecdh': ecdh
Scenario 'schnorr': ecdh

Given I read the content of 'identity.keys'
Given I read the content of 'pubkeys.json'


# Given I have a 'keyring'
Given I have a 'base64' named 'schnorr'
Given I have a 'base64 dictionary' named 'schnorr.signature'
Given I have a 'ecdh public key' from 'Issuer'
Given I have a 'string dictionary' named 'identity'


When I verify the 'schnorr' has a signature in 'schnorr.signature' by 'Issuer' 
#When I create the schnorr public key

# When I create the ecdh signature of 'identity'
# When I rename the 'ecdh signature' to 'ecdh.signature.identity'

When I create the 'base64 dictionary' named 'keyring'
When I insert 'schnorr' in 'keyring'


Then print the 'identity'

Then print the 'keyring'

# then print data
"> ./contracts/zenswarm-oracle-key-issuance-1.zen
echo ✔ Imported zenswarm-oracle-key-issuance-1.zen

echo "{}" > ./contracts/zenswarm-oracle-key-issuance-1.keys
echo ✔ Imported zenswarm-oracle-key-issuance-1.keys

echo "
Scenario 'schnorr': create Schnorr signature

Given I have a 'keyring'

Given I have a 'string dictionary' named 'identity'

When I create the schnorr signature of 'identity'
# When I create the schnorr public key

When I rename the 'schnorr signature' to 'schnorr.signature.identity'

# Here we print the signatyre, the public key and the message
# Then print my 'schnorr public key' 
# Then print the 'schnorr signature'
# Then print the 'message'

Then print the 'identity'

Then print the 'schnorr.signature.identity'
"> ./contracts/zenswarm-oracle-key-issuance-2.zen
echo ✔ Imported zenswarm-oracle-key-issuance-2.zen


echo "
Scenario 'ecdh': ecdh
Scenario 'schnorr': ecdh

Given I read the content of 'keyring.json'

Given I have a 'keyring'
Given I have a 'string dictionary' named 'identity'

Given I have a 'base64' named 'schnorr.signature.identity'

When I create the ecdh signature of 'identity'
When I rename the 'ecdh signature' to 'ecdh.signature.identity'

When I create the ecdh public key 

Then print the 'identity'
Then print the 'ecdh.signature.identity'
Then print the 'schnorr.signature.identity'
Then print the 'ecdh public key'

"> ./contracts/zenswarm-oracle-key-issuance-3.zen
echo ✔ Imported zenswarm-oracle-key-issuance-3.zen

echo "{}" > ./contracts/zenswarm-oracle-key-issuance-3.keys
echo ✔ Imported zenswarm-oracle-key-issuance-3.keys


echo "
zenchain: 1.0
start: id_0
blocks:
  id_0:
    zenFile: zenswarm-oracle-key-issuance-1.zen
    keysFile: zenswarm-oracle-key-issuance-1.keys
    next: id_1
  id_1:
    zenFile: zenswarm-oracle-key-issuance-2.zen
    next: id_2
  id_2:
    zenFile: zenswarm-oracle-key-issuance-3.zen
    keysFile: zenswarm-oracle-key-issuance-3.keys

"> ./contracts/zenswarm-oracle-key-issuance.yml
echo ✔ Imported zenswarm-oracle-key-issuance.yml

echo "{\"Issuer\":{\"ecdh_public_key\":\"BE7M0w9jugjgxyLn5C4ws6tnViv5rRc1zVSz+sm0M2NJUaZPaweefY3p6di7Da24TazNZ0HYVHcOEnVYlSZevqY=\"}}" > ./contracts/pubkeys.json
echo ✔ Imported pubkeys.json




