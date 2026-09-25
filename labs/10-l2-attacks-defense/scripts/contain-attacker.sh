#!/usr/bin/env bash

set -euo pipefail

sudo ip link set attacker down

echo "[+] Attacker access port administratively isolated."
ip link show attacker