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
RUN echo -e "# NOTE\n# pass it the paramater:\n# "Consensus": 3\n# or\n# # "Consensus": 6\n\n\nRule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\nGiven I have a 'number' named 'Consensus'\n\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\n\nWhen I create the 'string dictionary'\nWhen I rename the 'string dictionary' to 'randomIdentities'\n\nWhen I set 'consensus3' to '3' as 'number'\nWhen I set 'consensus6' to '6' as 'number'\n\n# When I create the length of 'identities'\n# When I rename the 'length' to 'howManyNodes'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '1'\nWhen I insert '1' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '2'\nWhen I insert '2' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '3'\nWhen I insert '3' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '4'\nWhen I insert '4' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '5'\nWhen I insert '5' in 'randomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '6'\nWhen I insert '6' in 'randomIdentities'\n\nIf I verify 'Consensus' is equal to 'consensus3'\nWhen I remove the '4' from 'randomIdentities'\nWhen I remove the '5' from 'randomIdentities'\nWhen I remove the '6' from 'randomIdentities'\nThen print 'randomIdentities'\nThen print string 'Consensus with 3 nodes was chosen'\nEndif \n\nIf I verify 'Consensus' is equal to 'consensus6'\nThen print 'randomIdentities'\nThen print string 'Consensus with 6 nodes was chosen'\nEndif \n\nIf I verify 'Consensus' is not equal to 'consensus6'\nIf I verify 'Consensus' is not equal to 'consensus3'\nThen print string 'STOCAZZO!'\nEndif \n\n# Then print 'howManyNodes'\n\n\n"> ./zencode/consensusroom-get-3or6RandomIdentities.zen
RUN echo -e "Rule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\n\nGiven I have a 'string dictionary' named 'identity'\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\n\nWhen I insert 'identity' in 'identities'\n\nThen print the 'identities'\nThen I write all data into redis under the key 'listOfIdentities'"> ./zencode/consensusroom-add-identity.zen
RUN echo -e "Rule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\nThen print the 'identities'"> ./zencode/consensusroom-get-listOfIdentities.zen
RUN echo -e "Rule caller restroom-mw\nGiven I have a valid redis connection on 'redis://localhost:6379'\nGiven I read from redis the data under the key 'listOfIdentities' and save the output into 'redisResult'\nGiven I have a 'string dictionary' named 'redisResult'\n\n\nWhen I create the copy of 'identities' from dictionary 'redisResult'\nWhen I rename the 'copy' to 'identities'\n\nWhen I create the 'string dictionary'\nWhen I rename the 'string dictionary' to '3RandomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '1'\nWhen I insert '1' in '3RandomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '2'\nWhen I insert '2' in '3RandomIdentities'\n\nWhen I pick the random object in 'identities'\nWhen I remove the 'random object' from 'identities'\nWhen I rename the 'random object' to '3'\nWhen I insert '3' in '3RandomIdentities'\n\n\nThen print the '3RandomIdentities'\n"> ./zencode/consensusroom-get-3RandomIdentities.zen

# yarn install and run
CMD yarn start


