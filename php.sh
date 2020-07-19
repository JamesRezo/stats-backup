#!/usr/bin/env bash

tail -n +2 history/php.csv | while IFS="," read -a LINE
do
    POLL_DATE="${LINE[0]}"
    POLL_DATE=$(sed "s#\(.*\)/\(.*\)/\(.*\)#\3/\2/\1#" <<< "$POLL_DATE")
    POLL_FILE="php/$POLL_DATE/010000.json"
    TOUCH_DATE=$(tr -d "/" <<< "${POLL_DATE}0100")
    echo "mkdir -p php/$POLL_DATE"
    PHP74=${LINE[1]:-0}
    PHP73=${LINE[2]:-0}
    PHP72=${LINE[3]:-0}
    PHP71=${LINE[4]:-0}
    PHP70=${LINE[5]:-0}
    PHP56=${LINE[6]:-0}
    PHP55=${LINE[7]:-0}
    PHP54=${LINE[8]:-0}
    PHP53=${LINE[9]:-0}
    PHP52=${LINE[10]:-0}
    PHP51=${LINE[11]:-0}
    PHP50=${LINE[12]:-0}
    PHP44=${LINE[13]:-0}
    PHP43=${LINE[14]:-0}
    echo "jq -n --arg version 7.4 --argjson sites \"$PHP74\" '[{version: \$version, sites: \$sites}|select(.sites>0)]' > $POLL_FILE"
    echo "jq --arg version 7.3 --argjson sites \"${PHP73}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 7.2 --argjson sites \"${PHP72}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 7.1 --argjson sites \"${PHP71}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 7.0 --argjson sites \"${PHP70}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.6 --argjson sites \"${PHP56}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.5 --argjson sites \"${PHP55}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.4 --argjson sites \"${PHP54}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.3 --argjson sites \"${PHP53}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.2 --argjson sites \"${PHP52}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.1 --argjson sites \"${PHP51}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 5.0 --argjson sites \"${PHP50}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 4.4 --argjson sites \"${PHP44}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "jq --arg version 4.3 --argjson sites \"${PHP43}\" '.|[.[], {version: \$version, sites: \$sites}|select(.sites>0)]' $POLL_FILE > tmp.json"
    echo "mv tmp.json $POLL_FILE"
    echo "touch -t $TOUCH_DATE $POLL_FILE"
    echo
done

exit 0
