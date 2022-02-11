#!/usr/bin/env bash 

# echo "${red}red text ${green}green text${reset}"
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${reset} "
echo "   "
echo "Make sure you have node 16, the version you have is" 
echo "   "
node -v
echo "   "
echo "   "
# Installing restroom
npx --yes degit dyne/restroom-template restroom-mw --force


# setup docker
cd ./restroom-mw


# TO BE IMPLEMENTED
# - get the hostname
# - create string "baserUrl": "hostname:3300"
# - generate keypair
# - create string "uid": "random"
# - insert it in mySelf.keys, based on: 



# {
# 	"identity": {
# 		"Kenshiro": {
# 			"baseUrl": "http://192.168.0.100:3030",
# 			"public_key": "BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=",
# 			"version": "1",
# 			"uid": "Kenshiro",
# 			"announce": "/api/consensusroom-announce",
# 			"get-6-timestamps": "/api/consensusroom-get-6-timestamps",
# 			"timestampAPI": "/api/consensusroom-get-timestamp"
# 		}
# 	}
# }

touch .env
echo 'ZENCODE_DIR=./zencode
CUSTOM_404_MESSAGE=nothing to see here
HTTP_PORT=3300
HTTPS_PORT=3301' > .env


# Adding the exported files
echo "   "
echo "Adding exported contracts from apiroom"

echo Creating directory "./zencode/dyneorg/"
mkdir -p "./zencode/dyneorg"

echo Creating file "consensusroom-get-timestamp.zen":
echo "Rule caller restroom-mw
Given I have a 'string' named 'myTimestamp'
Given I fetch the local timestamp and store it into 'myTimestamp'
Then print 'myTimestamp'"> ./zencode/consensusroom-get-timestamp.zen

echo Creating file "consensusroom-announce-p1.zen":
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
"> ./zencode/consensusroom-announce-p1.zen

echo Creating file "consensusroom-announce-p1.keys":
echo '{}' > ./zencode/consensusroom-announce-p1.keys

echo Creating file "consensusroom-announce-p2.zen":
echo "Rule caller restroom-mw

Given I have a 'string' named 'add-identity'
Given I have a 'string dictionary' named 'identity'
# Given I have a 'string dictionary' named 'output'
Given I have a 'string dictionary' named 'output'
Given I connect to 'add-identity' and pass it the content of 'identity' and save the output into 'output'


Then print the 'output'


"> ./zencode/consensusroom-announce-p2.zen

echo Creating file "consensusroom-announce-p2.keys":
echo '{}' > ./zencode/consensusroom-announce-p2.keys

echo Creating file "consensusroom-get-6-timestamps-p1.zen":
echo "
# Always use 'Rule caller restroom-mw' when using Restroom
Rule caller restroom-mw

Given I have a 'string dictionary' named '1'
Given I have a 'string dictionary' named '2'
Given I have a 'string dictionary' named '3'
Given I have a 'string dictionary' named '4'
Given I have a 'string dictionary' named '5'
Given I have a 'string dictionary' named '6'


When I create the copy of 'baseUrl' from dictionary '1'
When I rename the 'copy' to 'ts1'
When I create the copy of 'timestampAPI' from dictionary '1'
When I rename the 'copy' to 'api1'
When I append 'api1' to 'ts1'

When I create the copy of 'baseUrl' from dictionary '2'
When I rename the 'copy' to 'ts2'
When I create the copy of 'timestampAPI' from dictionary '2'
When I rename the 'copy' to 'api2'
When I append 'api2' to 'ts2'

When I create the copy of 'baseUrl' from dictionary '3'
When I rename the 'copy' to 'ts3'
When I create the copy of 'timestampAPI' from dictionary '3'
When I rename the 'copy' to 'api3'
When I append 'api3' to 'ts3' 

When I create the copy of 'baseUrl' from dictionary '4'
When I rename the 'copy' to 'ts4'
When I create the copy of 'timestampAPI' from dictionary '4'
When I rename the 'copy' to 'api4'
When I append 'api4' to 'ts4' 

When I create the copy of 'baseUrl' from dictionary '5'
When I rename the 'copy' to 'ts5'
When I create the copy of 'timestampAPI' from dictionary '5'
When I rename the 'copy' to 'api5'
When I append 'api5' to 'ts5' 

When I create the copy of 'baseUrl' from dictionary '6'
When I rename the 'copy' to 'ts6'
When I create the copy of 'timestampAPI' from dictionary '6'
When I rename the 'copy' to 'api6'
When I append 'api6' to 'ts6' 


Then print '1'
Then print '2'
Then print '3'
Then print '4'
Then print '5'
Then print '6'


Then print 'ts1'
Then print 'ts2'
Then print 'ts3'
Then print 'ts4'
Then print 'ts5'
Then print 'ts6'

"> ./zencode/consensusroom-get-6-timestamps-p1.zen

echo Creating file "consensusroom-get-6-timestamps-p1.keys":
echo '{}' > ./zencode/consensusroom-get-6-timestamps-p1.keys

echo Creating file "consensusroom-verify-announce.wip.zen":
echo "Rule caller restroom-mw


Given I have a 'string dictionary' named 'identity'
Given I have a 'string dictionary' named 'output'

When I create the copy of 'identities' from dictionary 'output'
When I rename the 'copy' to 'identities'

# When the content of 'identity' is found in 'identities'


 Then print data
"> ./zencode/consensusroom-verify-announce.wip.zen

echo Creating file "consensusroom-verify-announce.wip.keys":
echo '{"identity":{"Pepponzolo1":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"}},"output":{"identities":{"Burt":{"baseUrl":"http://192.168.0.110:3030","ip":"192.168.0.110","public_key":"BHZtsy1qifMCrXzF5nD1RFB4YY0SdbnHA1Pu4i0DfYIfNetlXgIQ9p7b7zzGJyP0XuJtQKA619MR3OIxDRheAV0=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Burt","version":"1"},"Fudo":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.107:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.107","public_key":"BDCgK49Ow7+AparlUmnZxo0i1+urG/zGXcjyPoM7miskpncr01HfWp4CecJE2bvYDuHkVvTSLDCruBJCNTUK+ss=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Fudo","version":"1"},"Jagger":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.103:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.103","public_key":"BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Jagger","version":"1"},"Julia":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.108:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.108","public_key":"BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Julia","version":"1"},"Kenshiro":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.100:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Kenshiro","version":"1"},"Lynn":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.111:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.111","public_key":"BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Lynn","version":"1"},"Pepero":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"},"Pepponzolo":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"},"Pepponzolo1":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"},"Raoul":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.102:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.102","public_key":"BD4TvvylaYTtahyKLGARzKervHaQxE6jxqXguYf4LfZDRxFC1qOBKloDkkO1+86EqAdh4Bpxx2w0I1y9DPgCVMM=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Raoul","version":"1"},"Rei":{"announce":"/consensusroom-announce","baseUrl":"http://192.168.0.105:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.105","public_key":"BLQWijG60cudq9uXErzowuBXP4fOWxFUkIfJxg6hnbDBQXa+nJWEd0WzFP8WMuTeUn5lsialbIltF1z1WLpW4eg=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Rei","version":"1"},"Ryuken":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.104:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.104","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Ryuken","version":"1"},"Souther":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.109:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.109","public_key":"BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Souther","version":"1"},"Toki":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.101:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.101","public_key":"BHzW7Y2wTfMsL0IYRwue8MTBVJX5vEH1xgCs0ayC033MZ2BRNXFU92YLF7GwW0IpFzPgl1YlMepTWD26vlMwWr8=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Toki","version":"1"},"Yuda":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.112:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.112","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Yuda","version":"1"}}}}' > ./zencode/consensusroom-verify-announce.wip.keys

echo Creating file "consensusroom-server-initIdentities.zen":
echo "# This script creates a list of mock identities for testing purposes
# It will overwrite your existing "listOfIdentities", so use it with caution

Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I have a 'string dictionary' named 'identities'
Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-server-initIdentities.zen

echo Creating file "consensusroom-server-initIdentities.keys":
echo '{"identities":{"Kenshiro":{"ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","name":"Kenshiro"},"Toki":{"ip":"192.168.0.101","public_key":"BHzW7Y2wTfMsL0IYRwue8MTBVJX5vEH1xgCs0ayC033MZ2BRNXFU92YLF7GwW0IpFzPgl1YlMepTWD26vlMwWr8=","name":"Toki"},"Raoul":{"ip":"192.168.0.102","public_key":"BD4TvvylaYTtahyKLGARzKervHaQxE6jxqXguYf4LfZDRxFC1qOBKloDkkO1+86EqAdh4Bpxx2w0I1y9DPgCVMM=","name":"Raoul"},"Jagger":{"ip":"192.168.0.103","public_key":"BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=","name":"Jagger"},"Ryuken":{"ip":"192.168.0.104","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Ryuken"},"Rei":{"ip":"192.168.0.105","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Rei"},"Fudo":{"ip":"192.168.0.107","public_key":"BDCgK49Ow7+AparlUmnZxo0i1+urG/zGXcjyPoM7miskpncr01HfWp4CecJE2bvYDuHkVvTSLDCruBJCNTUK+ss=","name":"Fudo"},"Julia":{"ip":"192.168.0.108","public_key":"BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=","name":"Julia"},"Souther":{"ip":"192.168.0.109","public_key":"BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=","name":"Souther"},"Burt":{"ip":"192.168.0.110","public_key":"BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=","name":"Burt"},"Lynn":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Lynn"},"Yuda":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Yuda"}}}' > ./zencode/consensusroom-server-initIdentities.keys

echo Creating file "consensusroom-server-get-listOfIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'
Then print the 'identities'"> ./zencode/consensusroom-server-get-listOfIdentities.zen

echo Creating file "consensusroom-server-get-6RandomIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'


When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I create the 'string dictionary'
When I rename the 'string dictionary' to '6RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '1'
When I insert '1' in '6RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '2'
When I insert '2' in '6RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '3'
When I insert '3' in '6RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '4'
When I insert '4' in '6RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '5'
When I insert '5' in '6RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '6'
When I insert '6' in '6RandomIdentities'

Then print the '6RandomIdentities'
"> ./zencode/consensusroom-server-get-6RandomIdentities.zen

echo Creating file "consensusroom-server-get-3or6RandomIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'
Given I have a 'number' named 'Consensus'


When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I create the 'string dictionary'
When I rename the 'string dictionary' to 'randomIdentities'

When I set 'consensus3' to '3' as 'number'
When I set 'consensus6' to '6' as 'number'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '1'
When I insert '1' in 'randomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '2'
When I insert '2' in 'randomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '3'
When I insert '3' in 'randomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '4'
When I insert '4' in 'randomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '5'
When I insert '5' in 'randomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '6'
When I insert '6' in 'randomIdentities'

If I verify 'Consensus' is equal to 'consensus3'
When I remove the '4' from 'randomIdentities'
When I remove the '5' from 'randomIdentities'
When I remove the '6' from 'randomIdentities'
Then print 'randomIdentities'
Then print string 'Consensus with 3 nodes was chosen'
Endif 

If I verify 'Consensus' is equal to 'consensus6'
Then print 'randomIdentities'
Then print string 'Consensus with 6 nodes was chosen'
Endif 

If I verify 'Consensus' is not equal to 'consensus6'
If I verify 'Consensus' is not equal to 'consensus3'
Then print string 'STOCAZZO!'
Endif 

# Then print the 'randomIdentities'


"> ./zencode/consensusroom-server-get-3or6RandomIdentities.zen

echo Creating file "consensusroom-server-add-identity.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

Given I have a 'string dictionary' named 'identity'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I copy contents of 'identity' in 'identities'


Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'

# expects

# {
# 	"identity": {
# 		"Pepero": {
# 			"baseUrl": "http://192.168.0.100:3030",
# 			"ip": "192.168.0.100",
# 			"public_key": "BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=",
# 			"timeServer": "http://localhost:3312",
# 			"uid": "Kenshiro",
# 			"version": "1"
# 		}
# 	}
# }"> ./zencode/consensusroom-server-add-identity.zen

echo Creating file "consensusroom-server-add-identity.keys":
echo '{}' > ./zencode/consensusroom-server-add-identity.keys

echo Creating file "consensusroom-get-6-timestamps-p2.zen":
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








"> ./zencode/consensusroom-get-6-timestamps-p2.zen

echo Creating file "consensusroom-get-6-timestamps-p2.keys":
echo '{}' > ./zencode/consensusroom-get-6-timestamps-p2.keys

echo Creating file "consensusroom-get-timestamp.zen":
echo "Rule caller restroom-mw
Given I have a 'string' named 'myTimestamp'
Given I fetch the local timestamp and store it into 'myTimestamp'
Then print 'myTimestamp'"> ./zencode/consensusroom-get-timestamp.zen

echo Creating file "consensusroom-announce-p1.zen":
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
"> ./zencode/consensusroom-announce-p1.zen

echo Creating file "consensusroom-announce-p1.keys":
echo '{}' > ./zencode/consensusroom-announce-p1.keys

echo Creating file "consensusroom-announce-p2.zen":
echo "Rule caller restroom-mw

Given I have a 'string' named 'add-identity'
Given I have a 'string dictionary' named 'identity'
# Given I have a 'string dictionary' named 'output'
Given I have a 'string dictionary' named 'output'
Given I connect to 'add-identity' and pass it the content of 'identity' and save the output into 'output'


Then print the 'output'


"> ./zencode/consensusroom-announce-p2.zen

echo Creating file "consensusroom-announce-p2.keys":
echo '{}' > ./zencode/consensusroom-announce-p2.keys

echo Creating file "consensusroom-get-6-timestamps-p1.zen":
echo "
# Always use 'Rule caller restroom-mw' when using Restroom
Rule caller restroom-mw

Given I have a 'string dictionary' named '1'
Given I have a 'string dictionary' named '2'
Given I have a 'string dictionary' named '3'
Given I have a 'string dictionary' named '4'
Given I have a 'string dictionary' named '5'
Given I have a 'string dictionary' named '6'


When I create the copy of 'baseUrl' from dictionary '1'
When I rename the 'copy' to 'ts1'
When I create the copy of 'timestampAPI' from dictionary '1'
When I rename the 'copy' to 'api1'
When I append 'api1' to 'ts1'

When I create the copy of 'baseUrl' from dictionary '2'
When I rename the 'copy' to 'ts2'
When I create the copy of 'timestampAPI' from dictionary '2'
When I rename the 'copy' to 'api2'
When I append 'api2' to 'ts2'

When I create the copy of 'baseUrl' from dictionary '3'
When I rename the 'copy' to 'ts3'
When I create the copy of 'timestampAPI' from dictionary '3'
When I rename the 'copy' to 'api3'
When I append 'api3' to 'ts3' 

When I create the copy of 'baseUrl' from dictionary '4'
When I rename the 'copy' to 'ts4'
When I create the copy of 'timestampAPI' from dictionary '4'
When I rename the 'copy' to 'api4'
When I append 'api4' to 'ts4' 

When I create the copy of 'baseUrl' from dictionary '5'
When I rename the 'copy' to 'ts5'
When I create the copy of 'timestampAPI' from dictionary '5'
When I rename the 'copy' to 'api5'
When I append 'api5' to 'ts5' 

When I create the copy of 'baseUrl' from dictionary '6'
When I rename the 'copy' to 'ts6'
When I create the copy of 'timestampAPI' from dictionary '6'
When I rename the 'copy' to 'api6'
When I append 'api6' to 'ts6' 


Then print '1'
Then print '2'
Then print '3'
Then print '4'
Then print '5'
Then print '6'


Then print 'ts1'
Then print 'ts2'
Then print 'ts3'
Then print 'ts4'
Then print 'ts5'
Then print 'ts6'

"> ./zencode/consensusroom-get-6-timestamps-p1.zen

echo Creating file "consensusroom-get-6-timestamps-p1.keys":
echo '{}' > ./zencode/consensusroom-get-6-timestamps-p1.keys

echo Creating file "consensusroom-verify-announce.wip.zen":
echo "Rule caller restroom-mw


Given I have a 'string dictionary' named 'identity'
Given I have a 'string dictionary' named 'output'

When I create the copy of 'identities' from dictionary 'output'
When I rename the 'copy' to 'identities'

# When the content of 'identity' is found in 'identities'


 Then print data
"> ./zencode/consensusroom-verify-announce.wip.zen

echo Creating file "consensusroom-verify-announce.wip.keys":
echo '{"identity":{"Pepponzolo1":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"}},"output":{"identities":{"Burt":{"baseUrl":"http://192.168.0.110:3030","ip":"192.168.0.110","public_key":"BHZtsy1qifMCrXzF5nD1RFB4YY0SdbnHA1Pu4i0DfYIfNetlXgIQ9p7b7zzGJyP0XuJtQKA619MR3OIxDRheAV0=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Burt","version":"1"},"Fudo":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.107:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.107","public_key":"BDCgK49Ow7+AparlUmnZxo0i1+urG/zGXcjyPoM7miskpncr01HfWp4CecJE2bvYDuHkVvTSLDCruBJCNTUK+ss=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Fudo","version":"1"},"Jagger":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.103:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.103","public_key":"BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Jagger","version":"1"},"Julia":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.108:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.108","public_key":"BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Julia","version":"1"},"Kenshiro":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.100:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Kenshiro","version":"1"},"Lynn":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.111:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.111","public_key":"BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Lynn","version":"1"},"Pepero":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"},"Pepponzolo":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"},"Pepponzolo1":{"baseUrl":"http://192.168.0.100:3030","ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","timeServer":"http://localhost:3312","uid":"Kenshiro","version":"1"},"Raoul":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.102:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.102","public_key":"BD4TvvylaYTtahyKLGARzKervHaQxE6jxqXguYf4LfZDRxFC1qOBKloDkkO1+86EqAdh4Bpxx2w0I1y9DPgCVMM=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Raoul","version":"1"},"Rei":{"announce":"/consensusroom-announce","baseUrl":"http://192.168.0.105:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.105","public_key":"BLQWijG60cudq9uXErzowuBXP4fOWxFUkIfJxg6hnbDBQXa+nJWEd0WzFP8WMuTeUn5lsialbIltF1z1WLpW4eg=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Rei","version":"1"},"Ryuken":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.104:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.104","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Ryuken","version":"1"},"Souther":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.109:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.109","public_key":"BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Souther","version":"1"},"Toki":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.101:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.101","public_key":"BHzW7Y2wTfMsL0IYRwue8MTBVJX5vEH1xgCs0ayC033MZ2BRNXFU92YLF7GwW0IpFzPgl1YlMepTWD26vlMwWr8=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Toki","version":"1"},"Yuda":{"announce":"/api/consensusroom-announce","baseUrl":"http://192.168.0.112:3030","get-6-timestamps":"/api/consensusroom-get-6-timestamps","ip":"192.168.0.112","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","timestampAPI":"/api/consensusroom-get-timestamp","uid":"Yuda","version":"1"}}}}' > ./zencode/consensusroom-verify-announce.wip.keys

echo Creating file "consensusroom-server-add-identity.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

Given I have a 'string dictionary' named 'identity'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I copy contents of 'identity' in 'identities'


Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'

# expects

# {
# 	"identity": {
# 		"Pepero": {
# 			"baseUrl": "http://192.168.0.100:3030",
# 			"ip": "192.168.0.100",
# 			"public_key": "BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=",
# 			"timeServer": "http://localhost:3312",
# 			"uid": "Kenshiro",
# 			"version": "1"
# 		}
# 	}
# }"> ./zencode/consensusroom-server-add-identity.zen

echo Creating file "consensusroom-server-add-identity.keys":
echo '{}' > ./zencode/consensusroom-server-add-identity.keys

echo Creating file "consensusroom-get-6-timestamps-p2.zen":
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








"> ./zencode/consensusroom-get-6-timestamps-p2.zen

echo Creating file "consensusroom-get-6-timestamps-p2.keys":
echo '{}' > ./zencode/consensusroom-get-6-timestamps-p2.keys


echo Creating file "consensusroom-announce.yml":
echo "zenchain: 1.0
start: id_0
blocks:
  id_0:
    zenFile: ./zencode/consensusroom-announce-p1.zen
    next: id_1
  id_1:
    zenFile: ./zencode/consensusroom-announce-p2.zen"> ./zencode/consensusroom-announce.yml

echo Creating file "consensusroom-get-6-timestamps.yml":
echo "zenchain: 1.0
start: id_0
blocks:
  id_0:
    zenFile: ./zencode/consensusroom-get-6-timestamps-p1.zen
    next: id_1
  id_1:
    zenFile: ./zencode/consensusroom-get-6-timestamps-p2.zen"> ./zencode/consensusroom-get-6-timestamps.yml


# Finished exported files
echo "   "
echo "Finished exporting contracts from apiroom"
echo "   "

# Debbing
echo "   "
echo "Printing the .env file:"
echo "   "
cat .env

# cd restroom-mw
yarn 
# yarn add @restroom-mw/core@next @restroom-mw/db@next @restroom-mw/http@next @restroom-mw/sawroom@next @restroom-mw/utils@next



cd zencode 
rm  confkeys.conf confkeys.keys confkeys.zen random.zen keypair_username.zen keypair_username.keys
rm -rf restroom-mw/
rm -rf misc/

echo " -------------------------- "
echo " ---- End debloating ---- "
echo " -------------------------- "


# instructions 
echo "   "
echo "${reset} "
echo "To launch restroom-mw, type:"
echo "${reset} "
echo "${red}cd restroom-mw"
echo "${reset} "
echo "${red}yarn start"
echo "${reset} "


