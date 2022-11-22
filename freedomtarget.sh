#!/bin/sh

QUERY=sys.argv[1]

for QUERY in $(echo $payload);do mkdir ${QUERY%} > /dev/2 null>&1 ./${QUERY%}/${QUERY%}-VULN > /dev/null 2>&1;
curl -s "https://beta.shodan.io/search/facet?query=$QUERY&facet=ip" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > ./${QUERY%}/${QUERY%}-ip-$(date +%Y-%m-%d).txt;
curl -s "https://beta.shodan.io/search/facet?query=$QUERY&facet=port" | grep -Eo '<strong>[0-9]{1,4}' | tr -d "<strong>" | sed 's/$/, /g' | xargs echo | sed 's/,$//g' | tr -d " "  > ./${QUERY%}/${QUERY%}-port-$(date +%Y-%m-%d).txt;
cat ./${QUERY%}/${QUERY%}-ip-$(date +%Y-%m-%d).txt | anew ./${QUERY%}/${QUERY%}-ip-new-$(date +%Y-%m-%d).txt;
cat ./${QUERY%}/${QUERY%}-port-$(date +%Y-%m-%d).txt  | anew ./${QUERY%}/${QUERY%}-port-new-$(date +%Y-%m-%d).txt;
