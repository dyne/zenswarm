# Consensusroom
Protototype of Zenroom based, client server consensus application

# Requirements
* node 16
* redis running on port 6379

# How to run the server

Clone, go into ./server and:

## How to run locally
Run **exportRestroom.sh* to install locally

## How to run in Docker
Run

**docker build --tag dyne/restroom_mw:latest .**

and

**docker run -d -p 3300:3300 -p 3301:3301 dyne/restroom_mw:latest**

## APIs
* ***/consensusroom-initIdentities***  needs no parameter, stores (and overwrites!) in redis a list of mock identities 
* ***/consensusroom-get-listOfIdentities*** needs no parameter, returns the full list of identities stored
* ***/consensusroom-get-3RandomIdentities*** needs no parameter, returns 3 random identities picked from the list of identities
* ***/consensusroom-get-3or6RandomIdentities*** needs parameter **"Consensus" : 3** (or 6), returns 3 or 6 random identities picked from the list of identities
* ***/consensusroom-add-identity*** needs parameter **"identity":{"stuff":"someStuff", "moreStuff":"moreStuff"}**, stores a new identity in the list of identities
