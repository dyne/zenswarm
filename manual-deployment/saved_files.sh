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
Rule caller restroom-mw


Given I have a 'string dictionary' named 'identity'
Given I have a 'string dictionary' named 'keypair'
Given I have a 'string' named  'uid' in 'identity'

Given I have a 'string' named  'public key' in 'keypair'
Given I have a 'string' named  'private key' in 'keypair'

Given I have a 'string' named  'myRandom'
Given I have a 'string' named  'keypair.json' 
Given I have a 'string' named  'identity.json' 
Given I have a 'string' named  'consensusroom-announce.json' 

When I set 'separator' to '|' as 'string'

When I append 'separator' to 'uid'

When I append 'myRandom' to 'uid'


When I insert 'public key' in 'identity' 
When I insert 'uid' in 'identity' 

Then print the 'identity'
Then print the 'keypair'
Then print the 'keypair.json'
Then print the 'identity.json'
Then print the 'consensusroom-announce.json'

Then store 'keypair' in the file 'keypair.json'
Then store 'identity' in the file 'identity.json'
Then store 'identity' in the file 'consensusroom-announce.json'

"> ./contracts/consensusroom-create-identity-p1.zen
echo ✔ Imported consensusroom-create-identity-p1.zen


echo "
Rule caller restroom-mw


Given I have a 'string dictionary' named 'identity'
Given I have a 'string dictionary' named 'keypair'
Given I have a 'string' named  'uid' in 'identity'

Given I have a 'string' named  'public key' in 'keypair'
Given I have a 'string' named  'private key' in 'keypair'

Given I have a 'string' named  'myRandom'
Given I have a 'string' named  'keypair.json' 
Given I have a 'string' named  'identity.json' 
Given I have a 'string' named  'consensusroom-announce.json' 

When I set 'separator' to '|' as 'string'

When I append 'separator' to 'uid'

When I append 'myRandom' to 'uid'


When I insert 'public key' in 'identity' 
When I insert 'uid' in 'identity' 

# Then print data

Then print the 'identity'
Then print the 'keypair'
Then print the 'keypair.json'
Then print the 'identity.json'
Then print the 'consensusroom-announce.json'

Then store 'keypair' in the file 'keypair.json'
Then store 'identity' in the file 'identity.json'
Then store 'identity' in the file 'consensusroom-announce.json'

"> ./contracts/consensusroom-create-identity-p2.zen
echo ✔ Imported consensusroom-create-identity-p2.zen

echo "{\"keypair.json\":\"./keypair.json\",\"identity.json\":\"./identity.json\",\"consensusroom-announce.json\":\"./consensusroom-announce.json\"}" > ./contracts/consensusroom-create-identity-p2.keys
echo ✔ Imported consensusroom-create-identity-p2.keys



echo "
zenchain: 1.0
start: id_0
blocks:
  id_0:
    zenFile: consensusroom-create-identity-p1.zen
    next: id_1
  id_1:
    zenFile: consensusroom-create-identity-p2.zen
    keysFile: consensusroom-create-identity-p2.keys

"> ./contracts/consensusroom-create-identity.yml
echo ✔ Imported consensusroom-create-identity.yml 

echo "

Scenario 'ecdh': Create the keypair
Scenario 'ethereum': Create the keypair
Scenario 'reflow': Create the keypair
Scenario 'schnorr': Create the keypair

Given I have the 'keys'
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
