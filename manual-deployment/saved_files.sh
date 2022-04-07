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

# Always use 'Rule caller restroom-mw' when using Restroom
Rule caller restroom-mw

Given that I have an endpoint named 'endpoint' 

Given I connect to 'endpoint' and save the output into 'result'

Given I have a 'string array' named 'result'


When I create the copy of 'identities' from dictionary 'result'
When I rename the 'copy' to 'identities'

When I create the 'string array'
When I rename the 'string array' to 'timestamp-endpoints'


Then print the 'identities'
Then print the 'timestamp-endpoints'



"> ./contracts/consensusroom-get-6-timestamps-p1.zen
echo ✔ Imported consensusroom-get-6-timestamps-p1.zen

echo "{\"endpoint\":\"https://apiroom.net/api/dyneorg/consensusroom-server-get-6RandomIdentities\"}" > ./contracts/consensusroom-get-6-timestamps-p1.keys
echo ✔ Imported consensusroom-get-6-timestamps-p1.keys

echo "
Given I have a 'string dictionary' named 'temp'

When I create the copy of 'baseUrl' from dictionary 'temp'
When I rename the 'copy' to 'timestampEndpoint'
When I create the copy of 'timestampAPI' from dictionary 'temp'
When I rename the 'copy' to 'api'
When I append 'api' to 'timestampEndpoint'

When I insert 'timestampEndpoint' in 'temp'

Then print the 'temp'

"> ./contracts/consensusroom-get-6-timestamps-fe-pt2.zen
echo ✔ Imported consensusroom-get-6-timestamps-fe-pt2.zen


echo "

# Always use 'Rule caller restroom-mw' when using Restroom
Rule caller restroom-mw


Given I have a 'string dictionary' named '1'
Given I have a 'string dictionary' named '2'
Given I have a 'string dictionary' named '3'
Given I have a 'string dictionary' named '4'
Given I have a 'string dictionary' named '5'
Given I have a 'string dictionary' named '6'

Given I have a 'string' named 'ts1'
Given I have a 'string' named 'ts2'
Given I have a 'string' named 'ts3'
Given I have a 'string' named 'ts4'
Given I have a 'string' named 'ts5'
Given I have a 'string' named 'ts6'

Given I have a 'string dictionary' named 'timestamps'

Given I execute parallel GET to 'ts1' and save the result named 'timestamp1' within the object 'timestamps'
Given I execute parallel GET to 'ts2' and save the result named 'timestamp2' within the object 'timestamps'
Given I execute parallel GET to 'ts3' and save the result named 'timestamp3' within the object 'timestamps'
Given I execute parallel GET to 'ts4' and save the result named 'timestamp4' within the object 'timestamps'
Given I execute parallel GET to 'ts5' and save the result named 'timestamp5' within the object 'timestamps'
Given I execute parallel GET to 'ts6' and save the result named 'timestamp6' within the object 'timestamps'


# When I create the copy of 'timeServer' from dictionary '1'
# When I rename the 'copy' to 'ts1'

When I create the copy of 'timestamp1' from dictionary 'timestamps'
When I rename the 'copy' to 'timestamp1'
When I create the copy of 'myTimestamp' from dictionary 'timestamp1'
When I rename the 'copy' to 'myTimestamp'
When I insert 'myTimestamp' in '1'


When I create the copy of 'timestamp2' from dictionary 'timestamps'
When I rename the 'copy' to 'timestamp2'
When I create the copy of 'myTimestamp' from dictionary 'timestamp2'
When I rename the 'copy' to 'myTimestamp'
When I insert 'myTimestamp' in '2'


When I create the copy of 'timestamp3' from dictionary 'timestamps'
When I rename the 'copy' to 'timestamp3'
When I create the copy of 'myTimestamp' from dictionary 'timestamp3'
When I rename the 'copy' to 'myTimestamp'
When I insert 'myTimestamp' in '3'


When I create the copy of 'timestamp4' from dictionary 'timestamps'
When I rename the 'copy' to 'timestamp4'
When I create the copy of 'myTimestamp' from dictionary 'timestamp4'
When I rename the 'copy' to 'myTimestamp'
When I insert 'myTimestamp' in '4'


When I create the copy of 'timestamp5' from dictionary 'timestamps'
When I rename the 'copy' to 'timestamp5'
When I create the copy of 'myTimestamp' from dictionary 'timestamp5'
When I rename the 'copy' to 'myTimestamp'
When I insert 'myTimestamp' in '5'


When I create the copy of 'timestamp6' from dictionary 'timestamps'
When I rename the 'copy' to 'timestamp6'
When I create the copy of 'myTimestamp' from dictionary 'timestamp6'
When I rename the 'copy' to 'myTimestamp'
When I insert 'myTimestamp' in '6'





Then print '1'
Then print '2'
Then print '3'
Then print '4'
Then print '5'
Then print '6'


### NOTE
# The execute parallel needs to be done in Given









"> ./contracts/consensusroom-get-6-timestamps-p2.zen
echo ✔ Imported consensusroom-get-6-timestamps-p2.zen


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
    zenFile: consensusroom-get-6-timestamps-p1.zen
    keysFile: consensusroom-get-6-timestamps-p1.keys
    next: id_1
  id_1:
    forEach: identities
    index: temp
    zenFile: consensusroom-get-6-timestamps-fe-pt2.zen
    next: id_2
  id_2:
    zenFile: consensusroom-get-6-timestamps-p2.zen

"> ./contracts/consensusroom-get-6-timestamps.yml
echo ✔ Imported consensusroom-get-6-timestamps.yml
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

