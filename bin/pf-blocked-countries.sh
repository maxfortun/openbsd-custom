#!/usr/local/bin/bash -e

cd ${BASH_SOURCE[0]%/*}/..

cat etc/pf.blocked | xargs -L 1 geoiplookup | grep Country | sed 's/^GeoIP Country Edition: //g' | sort | uniq -c | sort -n
