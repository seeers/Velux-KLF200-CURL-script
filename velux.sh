#!/bin/bash
echo $1
TOKEN=$(curl 'http://192.168.0.126/api/v1/auth' -X POST -d '{"action":"login","params":{"password":"velux123"}}')
echo $TOKEN
USETOKEN=$(echo $TOKEN | grep -Po '(?<="token":")[^"]*')
echo $USETOKEN
echo $(curl 'http://192.168.0.126/api/v1/products' -X POST -d '{"action":"get","params":{}}' -H "Authorization: Bearer $USETOKEN")
SCENERES=$(curl 'http://192.168.0.126/api/v1/scenes' -X POST -d '{"action":"get","params":{}}' -H "Authorization: Bearer $USETOKEN")
echo $SCENERES
SCENEID=$(echo $SCENERES | grep -Po '(?<="name":"Rollo_zu","id":)[0-9]')
echo $SCENEID
echo $(curl 'http://192.168.0.126/api/v1/scenes' -X POST -d "{\"action\":\"run\",\"params\":{\"id\":$SCENEID}}" -H "Authorization: Bearer $USETOKEN")
echo $(curl 'http://192.168.0.126/api/v1/auth' -X POST -d '{"action":"logout","params":{}}' -H "Authorization: Bearer $USETOKEN")
