#1a
grep -Po "[INFO|ERROR][^\n]*" syslog.log

#1bd
echo "Error,Count" > error_message.csv
grep -Zo "ERROR .* [^\(]*" syslog.log | cut -c 7- | sort | uniq -c | sort -snr | while read count word; do echo "$word, $count" >> error_message.csv; done
