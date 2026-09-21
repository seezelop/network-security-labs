#!/usr/bin/env bash

set -e

echo "Setting OSPF cost 50 on r01 eth1..."

docker exec clab-lab07-r01 vtysh \
  -c "configure terminal" \
  -c "interface eth1" \
  -c "ip ospf cost 50"

sleep 2

echo
echo "=== Route after cost change ==="
docker exec clab-lab07-r01 \
  vtysh -c "show ip route 10.10.40.0/24"

echo
echo "Restoring automatic OSPF cost..."

docker exec clab-lab07-r01 vtysh \
  -c "configure terminal" \
  -c "interface eth1" \
  -c "no ip ospf cost"

sleep 2

echo
echo "=== Route after restoring cost ==="
docker exec clab-lab07-r01 \
  vtysh -c "show ip route 10.10.40.0/24"
