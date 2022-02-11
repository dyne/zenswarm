# Consensusroom
Protototype of Zenroom based, client server consensus application

# Requirements
* node 14
* (Server only) redis running on port 6379

# How to run 

For the server: Clone, run **server.sh* to install locally
For the instance: Clone, run **instance.sh* to install locally

## How to run in Docker
Run

**docker build --tag dyne/restroom_mw:latest .**

and

**docker run -d -p 3300:3300 -p 3301:3301 dyne/restroom_mw:latest**

## APIs

### All

* **/consensusroom-get-timestamp** needs no parameter, returns:

```json
{    
"myTimestamp": "1644584971367" 
  }
``` 

### Server
* **/consensusroom-server-initIdentities**  needs no parameter, stores (and overwrites!) in redis a list of mock identities 
* **/consensusroom-server-add-identity**  stores a new identity in the list of identities, input: 

```json
{
	"identity": {
		"Kenshiro": {
			"baseUrl": "http://192.168.0.100:3030",
			"ip": "192.168.0.100",
			"public_key": "BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=",
			"timeServer": "http://localhost:3312",
			"uid": "Kenshiro",
			"version": "1",
			"test": "1"
		}
	}
}
``` 

* **/consensusroom-server-get-listOfIdentities** needs no parameter, returns the full list of identities stored
* **/consensusroom-server-get-6RandomIdentities** needs no parameter, returns 3 random identities picked from the list of identities
* **/consensusroom-server-get-3or6RandomIdentities** returns 3 or 6 random identities picked from the list of identities, input: 

```json
{    
"Consensus": 3 
  }
``` 

### Instance 


*  **/api/consensusroom-announce**  announces itself to the server, the input is the same as the endpoint /consensusroom-server-add-identity
*  **/consensusroom-get-6-timestamps**  returns 6 timestamps, the input is the output from /consensusroom-server-get-3or6RandomIdentities

```json
{
	"1": {
		"baseUrl": "http://192.168.0.109:3030",
		"ip": "192.168.0.109",
		"public_key": "BH4DAzUaA3GXJ4blwyX14J8ZzExD8XZI1mU3VuS7MH+xrGJafIbjRZcEJ0t0SVDTK9OgiYbn3x3vPhlGbqwbJd8=",
		"timestampAPI": "/api/consensusroom-get-timestamp",
		"uid": "Souther",
		"version": "1"
	},
	"2": {
		"baseUrl": "http://192.168.0.111:3030",
		"ip": "192.168.0.111",
		"public_key": "BC/DiN9hGAD5Ff5AKDd3DiYhXPD0bk37nmw48f1mNYoVs9O9koTHH7ResvhpVcPXr8XIw5ank+hni9LLwKTW5gQ=",
		"timestampAPI": "/api/consensusroom-get-timestamp",
		"uid": "Lynn",
		"version": "1"
	},
	"3": {
		"baseUrl": "http://192.168.0.110:3030",
		"ip": "192.168.0.110",
		"public_key": "BHZtsy1qifMCrXzF5nD1RFB4YY0SdbnHA1Pu4i0DfYIfNetlXgIQ9p7b7zzGJyP0XuJtQKA619MR3OIxDRheAV0=",
		"timestampAPI": "/api/consensusroom-get-timestamp",
		"uid": "Burt",
		"version": "1"
	},
	"4": {
		"baseUrl": "http://192.168.0.103:3030",
		"ip": "192.168.0.103",
		"public_key": "BESKGbFfv5V2W+/p22ESRb6g4cz8hIdKEh/KGfiZ6jjlFh9XZN7Rz93qiAeCqJlQ6HdyuzF64Gu8dj1zlmNK2fU=",
		"timestampAPI": "/api/consensusroom-get-timestamp",
		"uid": "Jagger",
		"version": "1"
	},
	"5": {
		"baseUrl": "http://192.168.0.108:3030",
		"ip": "192.168.0.108",
		"public_key": "BHCJefNXQZUfzh/uu6RBr5qN/QE5zyxXlayeBP5Bd4zR8aYHh0QWMMQS5skWYSuDolWFFjjvgKYHHmUdaCaXqZk=",
		"timestampAPI": "/api/consensusroom-get-timestamp",
		"uid": "Julia",
		"version": "1"
	},
	"6": {
		"baseUrl": "http://192.168.0.105:3030",
		"ip": "192.168.0.105",
		"public_key": "BLQWijG60cudq9uXErzowuBXP4fOWxFUkIfJxg6hnbDBQXa+nJWEd0WzFP8WMuTeUn5lsialbIltF1z1WLpW4eg=",
		"timestampAPI": "/api/consensusroom-get-timestamp",
		"uid": "Rei",
		"version": "1"
	},
	"ts1": "http://192.168.0.109:3030/api/consensusroom-get-timestamp",
	"ts2": "http://192.168.0.111:3030/api/consensusroom-get-timestamp",
	"ts3": "http://192.168.0.110:3030/api/consensusroom-get-timestamp",
	"ts4": "http://192.168.0.103:3030/api(consensusroom-get-timestamp",
	"ts5": "http://192.168.0.108:3030/api/consensusroom-get-timestamp",
	"ts6": "http://192.168.0.105:3030/api/consensusroom-get-timestamp"
}

```