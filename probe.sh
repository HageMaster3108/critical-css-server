#!/bin/sh
API="http://localhost:5001/api/v1/css"
URL="http://localhost:5001/testpage.html"
CSS="http://localhost:5001/testpage.css"
KEY="probe--$(date +%F)"
EXPECTED="#a{display:block;width:500px;height:2000px;clear:both;background-color:aquamarine}"

JSON="{ \"page\": {\"key\":\"$KEY\",\"url\":\"$URL\",\"css\":\"$CSS\"}}"
echo "Sending API $API - Request: $JSON"

OUTFILE=`mktemp`
echo $OUTFILE
curl -vvv -H "Content-Type: application/json" -X POST -d "$JSON" $API -o $OUTFILE

if [ "$?" != "0" ]; then
    echo "API request failed, curl exit code $?"
    exit $?
fi 

RETURNED_DATA=`cat $OUTFILE`

if [ "$RETURNED_DATA" = "Accepted" ]; then
    echo "Request seems to be in queue, waiting 10 sec for it to finish"
    sleep 10

    curl -vvv -H "Content-Type: application/json" -X POST -d "$JSON" $API -o $OUTFILE

    if [ "$?" != "0" ]; then
        echo "API request failed, curl exit code $?"
        exit $?
    fi 

    RETURNED_DATA=`cat $OUTFILE`

fi

if [ "$RETURNED_DATA" != "$EXPECTED" ]; then
    echo "Expected response doesn't match expected response:\n$RETURNED_DATA";
    exit 1
fi

echo "Response matches expected data"
#cat $OUTFILE