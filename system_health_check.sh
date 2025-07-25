#!/bin/bash

threshold=80
cpu_threshold=2.5
memory_threshold=80
report="---- System Health Check Report ----\n"
report+="Generated at: $(date)\n\n"

# Disk Usage
report+="Disk Usage:\n"
df -h | grep '^/dev/' | while read line; do
  usage=$(echo $line | awk '{print $5}' | tr -d '%')
  partition=$(echo $line | awk '{print $1}')
  if [ "$usage" -ge "$threshold" ]; then
    report+="WARNING: $partition is ${usage}% full!\n"
  else
    report+="$partition is ${usage}% full.\n"
  fi
done

# CPU Load Average (1-minute)
load=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
cpu_check=$(echo "$load > $cpu_threshold" | bc)
report+="\n CPU Load:\n"
if [ "$cpu_check" -eq 1 ]; then
  report+="WARNING: CPU Load is high ($load)\n"
else
  report+="CPU Load is normal ($load)\n"
fi

# Memory Usage
used_memory=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
used_int=$(printf "%.0f" "$used_memory")
report+="\n Memory Usage:\n"
if [ "$used_int" -ge "$memory_threshold" ]; then
  report+="WARNING: Memory usage is high (${used_int}%)\n"
else
  report+="Memory usage is normal (${used_int}%)\n"
fi

# Uptime
report+="\nUptime:\n$(uptime -p)\n"

# Users
report+="\nLogged-in Users:\n$(who)\n"

report+="\n---- End of Report ----\n"

# Output locally
echo -e "$report"

# Optional: Send to Slack
bash slack_alert.sh "$report"
