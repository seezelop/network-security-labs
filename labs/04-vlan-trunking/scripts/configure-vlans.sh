#!/usr/bin/env bash

set -e

# Access ports - VLAN 10 USERS
sudo ovs-vsctl set port sw1-u10 tag=10
sudo ovs-vsctl set port sw2-u10 tag=10

# Access ports - VLAN 20 SERVERS
sudo ovs-vsctl set port sw1-s20 tag=20
sudo ovs-vsctl set port sw2-s20 tag=20

# Trunk between SW1 and SW2
sudo ovs-vsctl set port sw1-trunk vlan_mode=trunk trunks=10,20
sudo ovs-vsctl set port sw2-trunk vlan_mode=trunk trunks=10,20