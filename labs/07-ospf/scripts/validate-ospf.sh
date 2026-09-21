#!/usr/bin/env bash

set -e

echo "=== OSPF neighbors on r01 ==="
docker exec clab-lab07-r01 \
  vtysh -c "show ip ospf neighbor"

echo
echo "=== Route to remote LAN ==="
docker exec clab-lab07-r01 \
  vtysh -c "show ip route 10.10.40.0/24"

echo
echo "=== Connectivity host-a -> host-b ==="
docker exec clab-lab07-host-a \
  ping -c 4 10.10.40.10
