#!/usr/bin/env bash

set -euo pipefail

CLIENT="clab-lab08-client01"

echo "=== DHCP / IPv4 ==="
docker exec "$CLIENT" ip -4 addr show dev eth1

echo
echo "=== Routing ==="
docker exec "$CLIENT" ip route get 10.20.20.10

echo
echo "=== DNS ==="
docker exec "$CLIENT" \
  dig @10.20.20.10 ntp.lab.local A +short

echo
echo "=== NTP ==="
docker exec "$CLIENT" sh -c \
  'printf "server 10.20.20.20 iburst\n" > /tmp/chrony-test.conf'

docker exec "$CLIENT" \
  chronyd -Q -t 5 -f /tmp/chrony-test.conf
