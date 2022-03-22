data=$(cat ./data.json)
echo "$data"

curl "https://apiroom.net/api/dyneorg/consensusroom-server-add-identity" -H "accept: application/json" -H "Content-Type: application/json" -d "$data"
