#!/usr/bin/env bash

set -euo pipefail

sudo ovs-vsctl --may-exist add-br sw01
sudo ip link set sw01 up

echo "[+] LAB 10 OVS bridge sw01 is ready."
