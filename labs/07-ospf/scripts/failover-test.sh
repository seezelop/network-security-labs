#!/usr/bin/env bash

set -e

echo "Disabling r01 -> r02 link..."
docker exec clab-lab07-r01 ip link set eth1 down

sleep 3

echo
echo "=== OSPF route after link failure ==="
docker exec clab-lab07-r01 \
  vtysh -c "show ip route 10.10.40.0/24"

echo
echo "=== OSPF neighbors after link failure ==="
docker exec clab-lab07-r01 \
  vtysh -c "show ip ospf neighbor"

echo
echo "Restoring link..."
docker exec clab-lab07-r01 ip link set eth1 up

sleep 3

echo
echo "Link restored."
