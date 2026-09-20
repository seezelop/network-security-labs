#!/usr/bin/env bash

set -e

# R01: route to the remote LAN through R02
docker exec clab-lab06-r01 \
  ip route replace 10.10.30.0/24 via 10.0.12.2

# R02: return routes to VLAN 10 and VLAN 20 through R01
docker exec clab-lab06-r02 \
  ip route replace 10.10.10.0/24 via 10.0.12.1

docker exec clab-lab06-r02 \
  ip route replace 10.10.20.0/24 via 10.0.12.1
