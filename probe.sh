#!/bin/sh

URL="https://google.com"
CSS=
curl -vvv -H "Content-Type: application/json" -X POST -d '{ "page": {"key":"unique-key2","url":"https://www.orthomol.com/","css":"https://www.orthomol.com/cache-buster-1661772970/css/main.css"}}' localhost:5001/api/v1/css