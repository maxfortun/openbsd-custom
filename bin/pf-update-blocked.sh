#!/usr/local/bin/bash -e

authlog=/var/log/backup/authlog*

grep 'Failed password for invalid' $authlog| awk '{ print $1, $2, $13 }'|sort|uniq -c|sort -n | while read count month day ip; do
	if [ "$count" -ge 7 ]; then
		echo "$ip"
	fi
done > etc/pf.blocked.invalid

grep 'Failed password for ' $authlog| grep -v 'invalid user'|awk '{ print $1, $2, $11 }'|sort|uniq -c|sort -n | while read count month day ip; do
    if [ "$count" -ge 7 ]; then
        echo "$ip"
    fi
done > etc/pf.blocked.valid

cat etc/pf.blocked* | sort -fu > etc/_pf.blocked

mv etc/_pf.blocked etc/pf.blocked

rm etc/pf.blocked.*

