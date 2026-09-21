#!/usr/bin/env bash

set -euo pipefail

CLIENT="clab-lab08-client01"

echo "[+] Requesting DHCP lease..."
docker exec "$CLIENT" udhcpc -i eth1 -q

echo "[+] Installing route to Services LAN..."
docker exec "$CLIENT" \
  ip route replace 10.20.20.0/24 via 10.20.10.1 dev eth1

echo
echo "[+] Client IPv4 configuration:"
docker exec "$CLIENT" ip -4 addr show dev eth1

echo
echo "[+] Route to DNS server:"
docker exec "$CLIENT" ip route get 10.20.20.10
