#!/usr/bin/env bash 


echo "\\nMake sure you have node 16, the version you have is\\n" 
node -v

# Installing restroom
npx create-restroom --all restroom-mw

# setup docker
cd ./restroom-mw




read LOWERPORT UPPERPORT < /proc/sys/net/ipv4/ip_local_port_range
while :
do
        PORT_HTTP="`shuf -i $LOWERPORT-$UPPERPORT -n 1`"
        ss -lpn | grep -q ":$PORT_HTTP " || break
done
echo $PORT_HTTP

read LOWERPORT UPPERPORT < /proc/sys/net/ipv4/ip_local_port_range
while :
do
        PORT_HTTPS="`shuf -i $LOWERPORT-$UPPERPORT -n 1`"
        ss -lpn | grep -q ":$PORT_HTTPS " || break
done
echo $PORT_HTTPS


echo "CUSTOM_404_MESSAGE=nothing to see here
HTTP_PORT=$PORT_HTTP
HTTPS_PORT=$PORT_HTTPS" > .env


echo "
{\"identity\":{\"uid\":\"random\",\"ip\":\"`hostname -I`\",\"baseUrl\":\"http://`hostname -I`\",\"port_http\":\"$PORT_HTTP\",\"port_https\":\"$PORT_HTTPS\",\"public_key\":\"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=\",\"version\":\"2\",\"announce\":\"/api/consensusroom-announce\",\"get-6-timestamps\":\"/api/consensusroom-get-6-timestamps\",\"timestampAPI\":\"/api/consensusroom-get-timestamp\"}}"

> ./contracts/identity.keys

echo ✔ Imported identity.keys



echo "
Rule caller restroom-mw
Scenario 'ecdh': verifies the signature from Apiroom 
Given I have a 'string dictionary' named 'updateInfo'
Given I have a 'string dictionary' named 'update' inside 'updateInfo'
Given I have a 'base64 dictionary' named 'update.signature' inside 'updateInfo'
# Given I have a 'string' named 'myFile' inside 'update'
Given I have a 'string' named 'myFolder' 

# Given I have a 'signature' named 'update.signature' 
Given I have a 'public key' from 'Apiroom' 

When I verify the 'update' has a signature in 'update.signature' by 'Apiroom' 

When I create the copy of 'myFile' from dictionary 'update'
When I rename the 'copy' to 'myFile'

Then print the string 'Zenroom verified the Apiroom signature are all correct!' 
Then print the 'myFile'
Then print the 'myFolder'

Then I download the 'myFile' and extract it into 'myFolder'
"> ./contracts/consensusroom-update.zen
echo ✔ Imported consensusroom-update.zen

echo "
{"Apiroom":{"public_key":"BPMbqmvEwUJsB6MmrswxKxza5+Lt82X20mAjcmknT7E7RysW6fACs/L3sXEOEh8qYxHKNAvcBCAetcIEuIEUVC4="},"myFolder":"/home/app/restroom-template-minimal/zencode/"}
"> ./contracts/consensusroom-update.keys
echo ✔ Imported consensusroom-update.keys

echo "

# Always use 'Rule caller restroom-mw' when using Restroom
Rule caller restroom-mw

Given that I have an endpoint named 'endpoint' 

Given I connect to 'endpoint' and save the output into 'result'

Given I have a 'string dictionary' named 'result'


When I create the copy of 'identities' from dictionary 'result'
When I rename the 'copy' to 'identities'




Then print the 'identities'



"> ./contracts/consensusroom-get-6-timestamps-p1.zen
echo ✔ Imported consensusroom-get-6-timestamps-p1.zen

echo "
{"endpoint":"https://apiroom.net/api/dyneorg/consensusroom-server-get-6RandomIdentities"}
"> ./contracts/consensusroom-get-6-timestamps-p1.keys
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

Given I have a 'string dictionary' named 'consensusMaster'
Given I have a 'string dictionary' named 'identity'


When I create the copy of 'add-identity' from dictionary 'consensusMaster'
When I rename the 'copy' to 'add-identity'

When I create the 'string dictionary'
When I rename the 'string dictionary' to 'data'

When I create the 'string dictionary'
When I rename the 'string dictionary' to 'post'

When I insert 'identity' in 'data'
When I insert 'data' in 'post'

# When I insert 'identity' in 'identities'

# Then print the 'identities'
Then print 'post'
Then print the 'add-identity'

"> ./contracts/consensusroom-announce-p1.zen
echo ✔ Imported consensusroom-announce-p1.zen

echo "
{}
"> ./contracts/consensusroom-announce-p1.keys
echo ✔ Imported consensusroom-announce-p1.keys

echo "
Rule caller restroom-mw

Given I have a 'string' named 'add-identity'
Given I have a 'string dictionary' named 'post'
# Given I have a 'string dictionary' named 'output'
Given I have a 'string dictionary' named 'output'
Given I connect to 'add-identity' and pass it the content of 'post' and save the output into 'output'


Then print the 'output'



"> ./contracts/consensusroom-announce-p2.zen
echo ✔ Imported consensusroom-announce-p2.zen



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
    zenFile: consensusroom-announce-p1.zen
    keysFile: consensusroom-announce-p1.keys
    next: id_1
  id_1:
    zenFile: consensusroom-announce-p2.zen

"> ./contracts/consensusroom-announce.yml
echo ✔ Imported consensusroom-announce.yml

# instructions 
echo \\nTo launch restroom-mw, type\\n:

red=`tput setaf 1`
echo "${red}cd restroom-mw"
echo "${red}yarn start"
