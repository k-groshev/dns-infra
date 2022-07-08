#!/bin/sh
set -e

# --rs-host - recursive nameserver
# --poll-size - size of peer pool
exec /opt/hnsd/hnsd --pool-size 4 --rs-host 127.0.0.1:53