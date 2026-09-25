#!/usr/bin/env bash

set -euo pipefail

sudo ovs-vsctl --if-exists del-br sw01

echo "[+] LAB 10 OVS bridge removed."