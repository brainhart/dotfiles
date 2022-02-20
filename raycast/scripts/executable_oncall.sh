#!/bin/bash

# @raycast.title OnCall
# @raycast.description Get Tecton OnCall and BuildCop rotations

# @raycast.icon 📞
# @raycast.mode inline
# @raycast.schemaVersion 1
# @raycast.refreshTime 2h

source "$HOME"/.pd_secret.sh

ONCALL=P3EGC02
SECONDARY=PQ8ULMZ
BUILDCOP=PNT78ZC

function get_person() {
  echo $(curl -s --request GET   --url "https://api.pagerduty.com/oncalls?time_zone=UTC&total=false&schedule_ids%5B%5D=${1}" --header 'accept: application/vnd.pagerduty+json;version=2'   --header "authorization: Token token=$PAGERDUTY_TOKEN"   --header 'content-type: application/json' | jq -r '.oncalls[0].user.summary' 2>/dev/null)
}

echo "1: $(get_person $ONCALL) | 2: $(get_person $SECONDARY) | Build: $(get_person $BUILDCOP)"
