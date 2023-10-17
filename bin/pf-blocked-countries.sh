#!/usr/local/bin/bash -e

cat etc/pf.blocked | xargs -L 1 geoiplookup | grep Country | sed 's/^GeoIP Country Edition: //g' | sort | uniq -c | sort -n
