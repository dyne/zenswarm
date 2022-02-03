# Consensusroom
Protototype of Zenroom based consensus

# Requirements
* node 16
* redis running on port 6379

# APIs
* ***/consensusroom-initIdentities***  needs no parameter, stores (and overwrites!) in redis a list of mock identities 
* ***/consensusroom-get-listOfIdentities*** needs no parameter, returns the full list of identities stored
* ***/consensusroom-get-3RandomIdentities*** needs no parameter, returns 3 random identities picked from the list of identities
* ***/consensusroom-get-3or6RandomIdentities*** needs parameter **"Consensus" : 3** (or 6), returns 3 or 6 random identities picked from the list of identities
* ***/consensusroom-add-identity*** needs parameter **"identity":{"stuff":"someStuff", "moreStuff":"moreStuff"}**, stores a new identity in the list of identities
