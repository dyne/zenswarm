# Importing node12 docker image
FROM node:12-alpine

# Add dependencies
RUN apk add git python3 make g++

# Installing restroom
RUN npx degit dyne/restroom-template /restroom-mw
WORKDIR /restroom-mw
RUN yarn

# OLD - Install the latest restroom-mw packages
# RUN yarn add @restroom-mw/core@next @restroom-mw/db@next @restroom-mw/http@next @restroom-mw/sawroom@next @restroom-mw/ui@next @restroom-mw/utils@next


# Configure restroom
ENV ZENCODE_DIR=/restroom-mw/zencode
ENV CUSTOM_404_MESSAGE="nothing to see here"
ENV HTTP_PORT=3300
ENV HTTPS_PORT=3301
ENV OPENAPI=true


RUN cd zencode \
rm -rf  confkeys.conf confkeys.keys confkeys.zen random.zen keypair_username.zen keypair_username.keys ./restroom-mw/ ./misc/


# Adding the exported files
RUN echo "Adding exported contracts from apiroom"
RUN echo -e "# This script creates a list of mock identities for testing purposes\n# It will overwrite your existing "listOfIdentities", so use it with caution\n\nRule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I have a 'string dictionary' named 'identities'\nThen print the 'identities'\nThen I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-initIdentities.zen
RUN echo -e '{"identities":{"Kenshiro":{"ip":"192.168.0.100","public_key":"BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=","name":"Kenshiro"},"Toki":{"ip":"192.168.0.101","public_key":"BHzW7Y2wTfMsL0IYRwue8MTBVJX5vEH1xgCs0ayC033MZ2BRNXFU92YLF7GwW0IpFzPgl1YlMepTWD26vlMwWr8=","name":"Toki"},"Raoul":{"ip":"192.168.0.102","public_key":"BD4TvvylaYTtahyKLGARzKervHaQxE6jxqXguYf4LfZDRxFC1qOBKloDkkO1+86EqAdh4Bpxx2w0I1y9DPgCVMM=","name":"Raoul"},"Jagger":{"ip":"192.168.0.103","public_key":"BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=","name":"Jagger"},"Ryuken":{"ip":"192.168.0.104","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Ryuken"},"Rei":{"ip":"192.168.0.105","public_key":"BH0wdFPEVGLeHukXJoxmZ5eJAzybOUchXszA1UNma4gZdbDWErVnMMdK7tYtPv+QSnzJfA6X2HumQ22RtjjRtOA=","name":"Rei"},"Fudo":{"ip":"192.168.0.107","public_key":"BDCgK49Ow7+AparlUmnZxo0i1+urG/zGXcjyPoM7miskpncr01HfWp4CecJE2bvYDuHkVvTSLDCruBJCNTUK+ss=","name":"Fudo"},"Julia":{"ip":"192.168.0.108","public_key":"BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=","name":"Julia"},"Souther":{"ip":"192.168.0.109","public_key":"BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=","name":"Souther"},"Burt":{"ip":"192.168.0.110","public_key":"BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=","name":"Burt"},"Lynn":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Lynn"},"Yuda":{"ip":"192.168.0.110","public_key":"BGCVU+TbYaaSSYYElVpHALuC8M7vmTdTUZsBrk1XB5WAOjK6knjHXF3g1CXx3nQeekMfTl963HvjXEaJitHLgI8=","name":"Yuda"}}}' > ./zencode/consensusroom-initIdentities.keys
RUN echo -e "# NOTE\n# pass it the paramater:\n# "Consensus": 3\n# or\n# # "Consensus": 6\n\n\nRule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\nGiven I have a 'number' named 'Consensus'\n\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\n\nWhen I create the 'string dictionary'\nWhen I rename the 'string dictionary' to 'randomIdentities'\n\nWhen I set 'consensus3' to '3' as 'number'\nWhen I set 'consensus6' to '6' as 'number'\n\n# When I create the length of 'identities'\n# When I rename the 'length' to 'howManyNodes'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '1'\nWhen I insert '1' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '2'\nWhen I insert '2' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '3'\nWhen I insert '3' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '4'\nWhen I insert '4' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '5'\nWhen I insert '5' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '6'\nWhen I insert '6' in 'randomIdentities'\n\nIf I verify 'Consensus' is equal to 'consensus3'\nWhen I remove the '4' from 'randomIdentities'\nWhen I remove the '5' from 'randomIdentities'\nWhen I remove the '6' from 'randomIdentities'\nThen print 'randomIdentities'\nThen print string 'Consensus with 3 nodes was chosen'\nEndif \n\nIf I verify 'Consensus' is equal to 'consensus6'\nThen print 'randomIdentities'\nThen print string 'Consensus with 6 nodes was chosen'\nEndif \n\nIf I verify 'Consensus' is not equal to 'consensus6'\nIf I verify 'Consensus' is not equal to 'consensus3'\nThen print string 'STOCAZZO!'\nEndif \n\n# Then print 'howManyNodes'\n\n\n"> ./zencode/consensusroom-get-3or6RandomIdentities.zen
RUN echo -e "Rule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\n\nGiven I have a 'string dictionary' named 'identity'\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\n\nWhen I insert 'identity' in 'identities'\n\nThen print the 'identities'\nThen I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-add-identity.zen
RUN echo -e "Rule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\nThen print the 'identities'"> ./zencode/consensusroom-get-listOfIdentities.zen
RUN echo -e "Rule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\n\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\n\nWhen I create the 'string dictionary'\nWhen I rename the 'string dictionary' to '3RandomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '1'\nWhen I insert '1' in '3RandomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '2'\nWhen I insert '2' in '3RandomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '3'\nWhen I insert '3' in '3RandomIdentities'\n\n\nThen print the '3RandomIdentities'\n"> ./zencode/consensusroom-get-3RandomIdentities.zen

# yarn install and run
CMD yarn start


