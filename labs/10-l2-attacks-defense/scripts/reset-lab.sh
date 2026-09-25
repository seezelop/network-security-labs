#!/usr/bin/env bash

set -euo pipefail

VICTIM="clab-lab10-victim01"

sudo ip link set attacker up

docker exec "$VICTIM" ip neigh flush dev eth1
docker exec "$VICTIM" ping -c 1 10.40.10.1

echo "[+] LAB 10 reset for another controlled test."
docker exec "$VICTIM" ip neigh show 10.40.10.1