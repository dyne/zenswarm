# Consensusroom
Protototype of Zenroom based, client server consensus application

# Requirements
* node 14
* (Server only) redis running on port 6379
* pm2

# How to run

- execute ./manual-deployment/instance-provisioning.sh

do **pm2 list ** to see how many instances of restroom_mw are running 

# MERMAID

``` mermaid
sequenceDiagram
    participant R as Register
    participant C1 as Random Client
    participant Cn as N-Clients
    C1->>C1: CREATE ID
    Cn->>Cn: CREATE ID
    C1->>R: ANNOUNCE ID
    Cn->>R: ANNOUNCE IDs
    C1->>R: ASK 6 random IDs
    R->>C1: REPLY 6 random IDs
    C1->>Cn: ASK 6 timestamps (x6)
    Cn->>C1: REPLY 6 timestamps (array)
    C1->>C1: CALCULATE average timestamp (WIP)
```

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
			"baseUrl": "http://192.168.0.100:3030",
			"ip": "192.168.0.100",
			"public_key": "BGiQeHz55rNc/k/iy7wLzR1jNcq/MOy8IyS6NBZ0kY3Z4sExlyFXcILcdmWDJZp8FyrILOC6eukLkRNt7Q5tzWU=",
			"timeServer": "http://localhost:3312",
			"uid": "Kenshiro",
			"version": "1",
			"test": "1"
	}
}
``` 

* **/consensusroom-server-get-listOfIdentities** needs no parameter, returns the full list of identities stored

Returns an array of objects like: 

```json
{
  "identities": [
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://192.168.1.41",
      "bitcoin_address": "bc1q5xngalmnf4vau3uuq8ssh3pp65dqzm0mtuxj44",
      "ecdh_public_key": "BN2H/OxIfEeX/ZUbRJvE3FvSkRrJrDl7x6U1+r8yMbvVKJ2o/C4B0/HusVTkyulzs2hiIij/2L6GvLCVgv4TOEE=",
      "ethereum_address": "a494024323222c4e9ac0fcbf7df460b0a393e6ad",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "192.168.1.41",
      "port_http": "39761",
      "port_https": "38361",
      "reflow_public_key": "DLQiNv10/RmHe5wa8lL9wKY9oXl3SYgT8/fF38dWZjFJPLamHOfiY5avIUfbOAVVBmooTgyYUWNsoWvzfT+32gXOfyLNNNVNL1nq/DLOxU89Kbm/+7cijpz+Ev1AcAHYFmxGGnL7sHh5bmKgAKT5A7UTYFoOr85Z/bZd/2o+1Ipmp7PPUihPIBwkfmCXIm3BAIVcIMqNZwhJe7nMm9iER8GUgK01ObOtlzqTq3ShpBmT5/OdbHZ+7SZj6g+ciich",
      "schnorr_public_key": "101889fafdb60fd8443a8c97f3063d06340e4b22a79c3e359bdede5e921c4710c1c0e6088568e4489701631911cbd5e5",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    },
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://192.168.1.41",
      "bitcoin_address": "bc1qy0z0k22srzz085lhesazw0fma9ae3ypsyrrvr3",
      "ecdh_public_key": "BDb0B6qWEJpz3RECjr58+ZWa1zGUan6zHfCF3PatfLzWRcQ78Lt1z9MM/qqyqmEi4tPkUr1n3SVOyD2XfbfXxYk=",
      "ethereum_address": "571df9f1de18f86b61a5124eb0f7859709eac6da",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "192.168.1.41",
      "port_http": "39379",
      "port_https": "41175",
      "reflow_public_key": "Cd/Npe5RSnyV+mt1IxNMNN9+UCKBCK7mEpT/mv1Q9ih14apmfKBTy4meNBUpSvRNGdRJ68ZUNcBfkDAQAG2RsCCJwPxn3GL+nmhz2xBRhJaxN0EyTfFTnG0uTohZP+Z/AiLS4bF8Nb4aKev6MJORzJTMX8pH3Lj95dtR10DcfhRe8kMcllDl7oXUHnqmcbPLBl27lPaGIABwgVAERCJuM5gxTJKMqluu67wcyVgijlXdu1jur40k+PcrjvOQTL5m",
      "schnorr_public_key": "066db2b2047271104ccedf31a2012f023eff28447811feb8928cb8629fbacfcc9ea4ee9d817382aa726a50d811814018",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    },
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://10.204.214.254",
      "bitcoin_address": "bc1qzn7zjfpvdsd5l0gt3fhn9hcn0qx4dnsa7yst4y",
      "ecdh_public_key": "BFX6UPhr0rDbv3zzMjhYXYthFddFrhcjmNzjGkjy5csnB9CpOgyu4Y4kIMuSMB+jZpX5EOR8iw0NU526t/+HO/o=",
      "ethereum_address": "391f2cedbfc845ea0db3df4b1f529810c5e7e0af",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "10.204.214.254",
      "port_http": "33579",
      "port_https": "41351",
      "reflow_public_key": "Ey341Uioo68+KuUla7SI4v9vioW3aJlHOFwhpv0bj1An8Rn1kQPX04C8a40GIfJjDSq5DA6KtZfbXGpMoQnIDoQuUzlNRikVqHFp19H5yIDnoSOpFR1TIIKkMOzX6+7EBdgIz8RRe92VoHQXgKPwgrJEnHzkmZWovm4VPzjPeO7vchinDLa77itsQICzzQT5FcOegZiVXCGMzADhxqUJRwiz9sme0XjORNQFyaDYqiOmxGXmSu5frNYhK/NXRkm0",
      "schnorr_public_key": "0c57c2b5a2cc43daaae2cf8eead24e23c62e38cd9870ab091b92005a7365f47f4916393a87769e19c8c11795dc56c30c",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    },
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://10.204.214.254",
      "bitcoin_address": "bc1qgrt69h8v83fc8ataw3a7ser6rzdcxutsvxz4pq",
      "ecdh_public_key": "BDNtfT0/sx9wVPSR9H+mjpRaD7zhjhksb8KPAibfqN2YHy6vv9ECCGh7sff8LlJTZPdTUBsZH2DiiknqsnrP6xs=",
      "ethereum_address": "aa8f7e1d2d9c85c4f450ba5cf841c31578a7aad0",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "10.204.214.254",
      "port_http": "42121",
      "port_https": "43493",
      "reflow_public_key": "Daww03xahKmIIkdWbeXar/veuyV56ib7PlD0TnZuXprmr6DHAStbXK/ZJG3xfMuRBpzrlW/p2liqLvStylCxBLAWN9kjLxGUUjLAQ5yknXh6DnqGRndzdsoTzT3bR6TnF7mtzH1Ro/0gNQ206nzhZaL4mqeJE2gG1x+mGZP6CrehlPLUWqj0xiQ9i9IiZZsVEXm0Y4n+nJw4w9wgs/8x7hNelDHvXP2xJWRPjfCs0ekT+wqRHIuMBaP9lqSz9aH/",
      "schnorr_public_key": "0c095bd75250368be273d928cca08c787aba8acf6af31dc163e1d120832dbaf73bbcc85b772728ffbc707f6bbff1a803",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    },
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://10.204.214.254",
      "bitcoin_address": "bc1qxsfjk2k6kunmkmhyur0gp5s5zhjcw72llkssgx",
      "ecdh_public_key": "BNKEZI/c5S1i0TOQKv2ZUB9hHtZA/IrsJBga2GOMgevLjNkMO8fKDykLrB7hRX07hvOkfwJE14Za2t+jkFQWTW8=",
      "ethereum_address": "823f56ad5386b3d3505e8c196f0905fba6525d8e",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "10.204.214.254",
      "port_http": "42573",
      "port_https": "38531",
      "reflow_public_key": "F9/NncAfcphm5s9Kw9YruSuwBXUSvPD/TaNyvYq5rkBlT2SQu0siNOftpXKHsPVLEPpzMNPHU7SrM3CXOHk1woRkEz87TwIzsNAG8ekqX+6gUiJftJTRrnH20smvZ/1ACKqG4iV/sAvanFSST84QQpXhisZjQewoBFKHKJhePVY6hnLa+ANDsFFxLr8nmrB7BeFF6eQMtyay94ACNa5zRZ86KCWBpA2A6arfVPGUi7L/ZocEYQbhVLUUmdg3cD0K",
      "schnorr_public_key": "0be32933a6a8be278e59f68676e8e7daa4401a4cff10756b172161520cf88e67b62b4d6afa3b97d80663a1a7da2d91f4",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    },
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://10.204.214.254",
      "bitcoin_address": "bc1qex58qawdr99upg6hx6pzeu4vsly394cg7mnuwg",
      "ecdh_public_key": "BAk6V54mtV0362oFnIGt/qPOb5o57KOOJx7KScdu+a+/1vTcZ0nYO8FtkuNJk7c1L4uLBuaZ8Q3uisii+nCJx2E=",
      "ethereum_address": "a78ed579726853d6761575813eaaaad79fb0988a",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "10.204.214.254",
      "port_http": "39641",
      "port_https": "38259",
      "reflow_public_key": "AzI8skvJE+UlLbCeGtMZZx8HzCfzzmjz/XtlH1VJpYLL875t4Idq/3QFYF0ILKUCFLgN1ncWcZDbLzwEl13+wSc2pvzrztF0tIQpAgY35Ju18znWOrJKsC2QcxVUDfyQBmPNkf8nAKdJ5xRhWtiNhh75Qx3HAHILy/odESRrKPsjk3xUbVCoyl4KJ0gx+h1jDVY6MAVwtb46QqfEP0ebnCW3SwedqRxjkfWddkiQMSo0p4iifB1jEzgfjSU1f6Fh",
      "schnorr_public_key": "00d892e798a8a4a22574f3e778296457ef477b6f8fa95589e85f5bd6afecb61742405087a60a8977ea7de39d0bbd63c3",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    },
    {
      "announceAPI": "/api/consensusroom-announce",
      "baseUrl": "http://10.204.214.254",
      "bitcoin_address": "bc1qz9sshm5l7029nnggqyftqqre5u372m90pq8p9p",
      "ecdh_public_key": "BNz4LBFlRL+Ik/+1pZ4mvI0PrwSYjosETf6Axw91oKAE1pmfxDLf5eofzqPiFgqgzwDefLPvlDIrY/C4i3qZjto=",
      "ethereum_address": "26a3f1224076b11d1a6b5a3077d126b98bebc39a",
      "get-6-timestampsAPI": "/api/consensusroom-get-6-timestamps",
      "ip": "10.204.214.254",
      "port_http": "45611",
      "port_https": "41297",
      "reflow_public_key": "AeLw9Z8Ag7jenNNP4Y5eQIeTnDtZuVMqz+U1HzvjqSNK58Gsy8oveFF2KTd5W/ISGaFm7nUKtnwKwQzySPE/QI4VQur/ZCwm+e8Y72E3jIpdmJaaDN2HJlpNXeMUqosHBkhwu0sMW5PRaxil8xGjfET+iZVsV0xt9A7IBhGej1vMr9oswNRteq99MaMrdtxcE/vgOTsdxR16WFwCsmCWTBBvBzMNEJ/JfrS6DJTfhEm8DkTc9aAuT5S9kbYWb1Vt",
      "schnorr_public_key": "08eaad7e99b34a13ba1078707cce51278b05d98f101964f3d390058a511a047adb31b7dafef01d6f012ebffe464a0cbc",
      "timestampAPI": "/api/consensusroom-get-timestamp",
      "tracker": "https://apiroom.net/",
      "uid": "random",
      "version": "2"
    }
  ]
}
``` 

* **/consensusroom-server-get-6RandomIdentities** needs no parameter, returns 3 random identities picked from the list of identities

Returns an array of objects as the previous API


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

### Update instances 

The instances now have update mechanism, triggered via an API (currently working only with 6 instances). The update flow to the instances is triggered by the API:

https://apiroom.net/api/dyneorg/consensusroom-server-update-6-instances.chain

The API needs no parameter.


# DevOps (Outdate)

Have ansible and GNU make installed

configure the token in linode-cli

`make all-up`

`make install`

`make deploy` - update all zencode scripts

`make announce` - announce all nodes

`make restart` - force reload of zencode scripts




For the server: Clone, run **server.sh* to install locally
For the instance: Clone, run **instance.sh* to install locally

## How to run in Docker
Run

**docker build --tag dyne/restroom_mw:latest .**

and

**docker run -d -p 3300:3300 -p 3301:3301 dyne/restroom_mw:latest**
