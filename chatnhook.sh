#!/bin/bash

# incoming web-hook URL and user name
url='CHANGEME'		# example: https://webhook.domain.com/<project_name>/zabbix

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (usually either PROBLEM or RECOVERY/OK)
# Message = $3 (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")

to="$1"
subject="$2"

# The message that we want to send to Chat 'n' is the "subject" value ($2 / $subject - that we got earlier)
#  followed by the message that Zabbix actually sent us ($3)
message="${subject}: $3"

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"text\": \"${message//\"/\\\"}\"}"
curl -m 5 --data-urlencode "${payload}" $url -A 'zabbix-chatnhook-alertscript / https://github.com/chatnhook/zabbix-alertscript'
