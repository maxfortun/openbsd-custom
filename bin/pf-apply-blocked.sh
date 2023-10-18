#!/usr/local/bin/bash -e

# Intended to run as root

cd ${BASH_SOURCE[0]%/*}/..

cp etc/pf.blocked /etc/pf.blocked

pfctl -f /etc/pf.conf
