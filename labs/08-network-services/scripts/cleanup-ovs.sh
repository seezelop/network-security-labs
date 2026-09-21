#!/usr/bin/env bash

set -euo pipefail

sudo ovs-vsctl --if-exists del-br sw01
sudo ovs-vsctl --if-exists del-br sw02

echo "[+] OVS bridges removed."
