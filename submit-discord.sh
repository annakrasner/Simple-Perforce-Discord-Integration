#!/bin/bash

#changelist num
CHANGE=$1 

#user
USER=$2

#webhook
WEBHOOK="YOUR WEBHOOK HERE"
ICON_URL="https://i.imgur.com/unlgXvg.png"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S%z)
#decimal color value
COLOR="10275223"

function json_stringify() {
    LANG=C command -p awk '
        BEGIN {
            ORS = ""
            for ( i = 1; i <= 127; i++ )
                tr[ sprintf( "%c", i) ] = sprintf( "\\u%04x", i )

            for ( i = 1; i < ARGC; i++ ) {
                s = ARGV[i]
                while ( match( s, /[\001-\037\177"\\]/ ) ) {
                    print substr(s,1,RSTART-1) tr[ substr(s,RSTART,RLENGTH) ]
                    s = substr(s,RSTART+RLENGTH)
                }
                print s" "
            }
        }
    ' "$@"
}

DESC=$(p4 -ztag -F %desc% describe -s $CHANGE)

DESC=$(json_stringify $DESC)

FANCY_PAYLOAD="{\"embeds\":[{\"title\":\"$USER submitted CL $CHANGE\",\"description\":\"$DESC\",\"color\":\"$COLOR\",
	 \"thumbnail\":{\"url\":\"\"},\"footer\":{\"text\":\"P4 Discord Integration\", \"icon_url\":\"$ICON_URL\"},\"timestamp\":\"$TIMESTAMP\"}]}"
	 

echo "$FANCY_PAYLOAD" > p4_payload_tmp.txt

curl --header "Content-Type: application/json" \
     -d @p4_payload_tmp.txt \
     $WEBHOOK
	 
	 
