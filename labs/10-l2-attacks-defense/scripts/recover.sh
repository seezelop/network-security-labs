#!/usr/bin/env bash

set -euo pipefail

VICTIM="clab-lab10-victim01"

echo "=== Removing poisoned ARP state ==="
docker exec "$VICTIM" \
  ip neigh del 10.40.10.1 dev eth1 2>/dev/null || true

echo
echo "=== Triggering legitimate ARP resolution ==="
docker exec "$VICTIM" ping -c 1 10.40.10.1

echo
echo "=== Restored gateway association ==="
docker exec "$VICTIM" ip neigh show 10.40.10.1

echo
echo "=== Connectivity validation ==="
docker exec "$VICTIM" ping -c 3 10.40.10.1