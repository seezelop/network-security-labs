#!/usr/bin/env bash

set -e

# Create switches
sudo ovs-vsctl --may-exist add-br sw01
sudo ovs-vsctl --may-exist add-br sw02

# Enable RSTP
sudo ovs-vsctl set Bridge sw01 rstp_enable=true
sudo ovs-vsctl set Bridge sw02 rstp_enable=true

# Make SW01 the preferred Root Bridge
sudo ovs-vsctl set Bridge sw01 other_config:rstp-priority=28672
sudo ovs-vsctl set Bridge sw02 other_config:rstp-priority=32768

# Bring switches up
sudo ip link set sw01 up
sudo ip link set sw02 up