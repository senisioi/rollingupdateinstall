#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
  then
    echo "Usage: admin-host-adress bearer haproxy-server-address"
    exit 1
fi

echo $3

sed -i.bak 's/admin_address/'$3'/g' create_rollingupdate.json

curl -ski      \
     -X "POST" \
     -H "Authorization: Bearer $2" "https://$1/api/v2/deployments/" \
     --data "@create_rollingupdate.json"

curl -ski      \
     -X "POST" \
     -H "Authorization: Bearer $2" "https://$1/api/v2/deployments/" \
     --data "@create_dockernode-db.json"

# mv create_rollingupdate.json.bak create_rollingupdate.json
