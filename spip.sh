#!/usr/bin/env bash

tail -n +2 history/spip.csv | while IFS="," read -a LINE
do
    POLL_DATE="${LINE[0]}"
    POLL_DATE=$(sed "s#\(.*\)/\(.*\)/\(.*\)#\3/\2/\1#" <<< "$POLL_DATE")
    POLL_FILE="spip/$POLL_DATE/010000.json"
    TOUCH_DATE=$(tr -d "/" <<< "${POLL_DATE}0100")
    echo "mkdir -p spip/$POLL_DATE"
    ALL=${LINE[1]:-0}
    SPIP33=${LINE[2]:-0}
    SPIP32=${LINE[3]:-0}
    SPIP31=${LINE[4]:-0}
    SPIP30=${LINE[5]:-0}
    SPIP21=${LINE[6]:-0}
    SPIP20=${LINE[7]:-0}
    SPIP19=${LINE[8]:-0}
    SPIP18=${LINE[9]:-0}
    SPIPOLDER=${LINE[10]:-0}
    SPIPUNKNOWN=${LINE[11]:-0}
    SPIPUNKNOWN=$(tr -d '[:space:]' <<< $SPIPUNKNOWN)
    SPIPUNKNOWN=${SPIPUNKNOWN:-0}
    echo "jq -n --arg version all --argjson sites \"$ALL\" '[{version: \$version, sites: \$sites}|select(.sites>0)]' > $POLL_FILE"
    echo "jq --arg version 3.3 --argjson sites \"${SPIP33}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 3.2 --argjson sites \"${SPIP32}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 3.1 --argjson sites \"${SPIP31}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 3.0 --argjson sites \"${SPIP30}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 2.1 --argjson sites \"${SPIP21}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 2.0 --argjson sites \"${SPIP20}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 1.9 --argjson sites \"${SPIP19}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 1.8 --argjson sites \"${SPIP18}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version older --argjson sites \"${SPIPOLDER}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version unknown --argjson sites \"${SPIPUNKNOWN}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "touch -t $TOUCH_DATE $POLL_FILE"
    echo
done

exit 0
