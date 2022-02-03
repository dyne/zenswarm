#!/usr/bin/env bash 

# echo "${red}red text ${green}green text${reset}"
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${reset} "
echo "   "
echo "Make sure you have node 12, the version you have is" 
echo "   "
node -v
echo "   "
echo "   "
# Installing restroom
npx degit dyne/restroom-template restroom-mw --force



# setup docker
cd ./restroom-mw

touch .env
echo 'ZENCODE_DIR=./zencode
CUSTOM_404_MESSAGE=nothing to see here
HTTP_PORT=3300
HTTPS_PORT=3301' > .env


# Adding the exported files
echo "   "
echo "Adding exported contracts from apiroom"

echo Creating directory "./zencode/bario4/"
mkdir -p "./zencode/bario4"

echo Creating file "consensusroom-initIdentities.zen":
echo "# This script creates a list of mock identities for testing purposes
# It will overwrite your existing "listOfIdentities", so use it with caution

Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I have a 'string dictionary' named 'identities'
Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-initIdentities.zen

echo Creating file "consensusroom-initIdentities.keys":
echo '{"identities":{"Kenshiro":{"ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","name":"Kenshiro"},"Toki":{"ip":"192.168.0.101","public_key":"BHzW7Y2wTfMsL0IYRwue8MTBVJX5vEH1xgCs0ayC033MZ2BRNXFU92YLF7GwW0IpFzPgl1YlMepTWD26vlMwWr8=","name":"Toki"},"Raoul":{"ip":"192.168.0.102","public_key":"BD4TvvylaYTtahyKLGARzKervHaQxE6jxqXguYf4LfZDRxFC1qOBKloDkkO1+86EqAdh4Bpxx2w0I1y9DPgCVMM=","name":"Raoul"},"Jagger":{"ip":"192.168.0.103","public_key":"BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=","name":"Jagger"},"Ryuken":{"ip":"192.168.0.104","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Ryuken"},"Rei":{"ip":"192.168.0.105","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Rei"},"Fudo":{"ip":"192.168.0.107","public_key":"BDCgK49Ow7+AparlUmnZxo0i1+urG/zGXcjyPoM7miskpncr01HfWp4CecJE2bvYDuHkVvTSLDCruBJCNTUK+ss=","name":"Fudo"},"Julia":{"ip":"192.168.0.108","public_key":"BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=","name":"Julia"},"Souther":{"ip":"192.168.0.109","public_key":"BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=","name":"Souther"},"Burt":{"ip":"192.168.0.110","public_key":"BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=","name":"Burt"},"Lynn":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Lynn"},"Yuda":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Yuda"}}}' > ./zencode/consensusroom-initIdentities.keys

echo Creating file "consensusroom-get-3or6RandomIdentities.zen":
echo "# NOTE
# pass it the paramater:
# "Consensus": 3
# or
# # "Consensus": 6


Rule caller restroom-mw
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

# When I create the length of 'identities'
# When I rename the 'length' to 'howManyNodes'

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

# Then print 'howManyNodes'


"> ./zencode/consensusroom-get-3or6RandomIdentities.zen

echo Creating file "consensusroom-add-identity.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

Given I have a 'string dictionary' named 'identity'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I insert 'identity' in 'identities'

Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-add-identity.zen

echo Creating file "consensusroom-get-listOfIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'
Then print the 'identities'"> ./zencode/consensusroom-get-listOfIdentities.zen

echo Creating file "consensusroom-get-3RandomIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'


When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I create the 'string dictionary'
When I rename the 'string dictionary' to '3RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '1'
When I insert '1' in '3RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '2'
When I insert '2' in '3RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '3'
When I insert '3' in '3RandomIdentities'


Then print the '3RandomIdentities'
"> ./zencode/consensusroom-get-3RandomIdentities.zen

echo Creating file "consensusroom-initIdentities.zen":
echo "# This script creates a list of mock identities for testing purposes
# It will overwrite your existing "listOfIdentities", so use it with caution

Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I have a 'string dictionary' named 'identities'
Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-initIdentities.zen

echo Creating file "consensusroom-initIdentities.keys":
echo '{"identities":{"Kenshiro":{"ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","name":"Kenshiro"},"Toki":{"ip":"192.168.0.101","public_key":"BHzW7Y2wTfMsL0IYRwue8MTBVJX5vEH1xgCs0ayC033MZ2BRNXFU92YLF7GwW0IpFzPgl1YlMepTWD26vlMwWr8=","name":"Toki"},"Raoul":{"ip":"192.168.0.102","public_key":"BD4TvvylaYTtahyKLGARzKervHaQxE6jxqXguYf4LfZDRxFC1qOBKloDkkO1+86EqAdh4Bpxx2w0I1y9DPgCVMM=","name":"Raoul"},"Jagger":{"ip":"192.168.0.103","public_key":"BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=","name":"Jagger"},"Ryuken":{"ip":"192.168.0.104","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Ryuken"},"Rei":{"ip":"192.168.0.105","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Rei"},"Fudo":{"ip":"192.168.0.107","public_key":"BDCgK49Ow7+AparlUmnZxo0i1+urG/zGXcjyPoM7miskpncr01HfWp4CecJE2bvYDuHkVvTSLDCruBJCNTUK+ss=","name":"Fudo"},"Julia":{"ip":"192.168.0.108","public_key":"BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=","name":"Julia"},"Souther":{"ip":"192.168.0.109","public_key":"BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=","name":"Souther"},"Burt":{"ip":"192.168.0.110","public_key":"BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=","name":"Burt"},"Lynn":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Lynn"},"Yuda":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Yuda"}}}' > ./zencode/consensusroom-initIdentities.keys

echo Creating file "consensusroom-get-3or6RandomIdentities.zen":
echo "# NOTE
# pass it the paramater:
# "Consensus": 3
# or
# # "Consensus": 6


Rule caller restroom-mw
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

# When I create the length of 'identities'
# When I rename the 'length' to 'howManyNodes'

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

# Then print 'howManyNodes'


"> ./zencode/consensusroom-get-3or6RandomIdentities.zen

echo Creating file "consensusroom-add-identity.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

Given I have a 'string dictionary' named 'identity'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I insert 'identity' in 'identities'

Then print the 'identities'
Then I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-add-identity.zen

echo Creating file "consensusroom-get-listOfIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'

When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'
Then print the 'identities'"> ./zencode/consensusroom-get-listOfIdentities.zen

echo Creating file "consensusroom-get-3RandomIdentities.zen":
echo "Rule caller restroom-mw
Given I have a valid redis connection on 'redis://localhost:6379'
Given I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'
Given I have a 'string dictionary' named 'redisResult'


When I create the copy of 'identities' from dictionary 'redisResult'
When I rename the 'copy' to 'identities'

When I create the 'string dictionary'
When I rename the 'string dictionary' to '3RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '1'
When I insert '1' in '3RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '2'
When I insert '2' in '3RandomIdentities'

When I pick the random object in 'identities'
When I remove the 'random object' from 'identities'
When I rename the 'random object' to '3'
When I insert '3' in '3RandomIdentities'


Then print the '3RandomIdentities'
"> ./zencode/consensusroom-get-3RandomIdentities.zen



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


