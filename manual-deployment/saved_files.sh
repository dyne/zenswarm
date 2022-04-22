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



