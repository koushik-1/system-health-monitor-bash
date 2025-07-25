#!/bin/bash
message=$1
WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

curl -X POST -H 'Content-type: application/json'   --data "{\"text\":\"$message\"}"   $WEBHOOK_URL > /dev/null 2>&1
