#!/usr/bin/env bash

set -e

# Access port - VLAN 10
sudo ovs-vsctl set Port sw01-user tag=10

# Access port - VLAN 20
sudo ovs-vsctl set Port sw01-server tag=20

# Trunk to router - VLANs 10 and 20
sudo ovs-vsctl set Port sw01-trunk vlan_mode=trunk trunks=10,20
