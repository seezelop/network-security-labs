#!/usr/bin/env bash

set -euo pipefail

R01="clab-lab10-r01"
VICTIM="clab-lab10-victim01"
ATTACKER="clab-lab10-attacker01"

echo "=== R01 legitimate MAC ==="
docker exec "$R01" cat /sys/class/net/eth1/address

echo
echo "=== Attacker MAC ==="
docker exec "$ATTACKER" cat /sys/class/net/eth1/address

echo
echo "=== Clearing victim ARP entry ==="
docker exec "$VICTIM" ip neigh flush dev eth1

echo
echo "=== Triggering legitimate ARP resolution ==="
docker exec "$VICTIM" ping -c 1 10.40.10.1

echo
echo "=== Victim gateway association ==="
docker exec "$VICTIM" ip neigh show 10.40.10.1