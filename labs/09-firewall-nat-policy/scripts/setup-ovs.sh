#!/usr/bin/env bash

set -euo pipefail

sudo ovs-vsctl --may-exist add-br sw01
sudo ovs-vsctl --may-exist add-br sw02

sudo ip link set sw01 up
sudo ip link set sw02 up

echo "[+] OVS bridges sw01 and sw02 are ready."
