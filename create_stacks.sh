#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
  then
    echo "Usage: admin-server-adress bearer haproxy-server-address"
    exit 1
fi

echo "Installing netcat on "$3" and deploying the rollingupdate tool and the dockernode sample app against the "$1" OCCS admin .."

scp public-yum-ol6.repo opc@$3:/tmp/public-yum-ol6.repo
scp yum.conf opc@$3:/tmp/yum.conf
ssh opc@$3 sudo mv /tmp/public-yum-ol6.repo /etc/yum.repos.d/public-yum-ol6.repo
ssh opc@$3 sudo mv /tmp/yum.conf /etc/yum.conf
ssh opc@$3 sudo yum -y install nc

sed -i.bak 's/admin_address/'$3'/g' create_rollingupdate.json

curl -si -k1      \
     -X "POST" \
     -H "Authorization: Bearer $2" "https://$1/api/v2/deployments/" \
     --data "@create_rollingupdate.json"

curl -si -k1      \
     -X "POST" \
     -H "Authorization: Bearer $2" "https://$1/api/v2/deployments/" \
     --data "@create_dockernode-db.json"

mv create_rollingupdate.json.bak create_rollingupdate.json
