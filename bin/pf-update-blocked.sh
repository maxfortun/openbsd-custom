#!/usr/local/bin/bash -e

grep 'Failed password for invalid' /var/log/authlog| awk '{ print $1, $2, $13 }'|sort|uniq -c|sort -n | while read count month day ip; do
	if [ "$count" -ge 7 ]; then
		echo "$ip"
	fi
done > etc/pf.blocked.invalid

grep 'Failed password for ' /var/log/authlog| grep -v 'invalid user'|awk '{ print $1, $2, $11 }'|sort|uniq -c|sort -n | while read count month day ip; do
    if [ "$count" -ge 7 ]; then
        echo "$ip"
    fi
done > etc/pf.blocked.valid

cat etc/pf.blocked* | sort -fu > etc/_pf.blocked

mv etc/_pf.blocked etc/pf.blocked

rm etc/pf.blocked.*

