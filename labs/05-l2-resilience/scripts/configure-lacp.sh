#!/usr/bin/env bash

set -e

# Disable RSTP for the LACP phase
sudo ovs-vsctl set Bridge sw01 rstp_enable=false
sudo ovs-vsctl set Bridge sw02 rstp_enable=false

# Remove previous LAGs if the script is executed again
sudo ovs-vsctl --if-exists del-port sw01 lag01
sudo ovs-vsctl --if-exists del-port sw02 lag02

# Remove links as independent switch ports
sudo ovs-vsctl --if-exists del-port sw01 sw01-link1
sudo ovs-vsctl --if-exists del-port sw01 sw01-link2
sudo ovs-vsctl --if-exists del-port sw02 sw02-link1
sudo ovs-vsctl --if-exists del-port sw02 sw02-link2

# Create LACP bundles
sudo ovs-vsctl add-bond sw01 lag01 sw01-link1 sw01-link2 \
  lacp=active bond_mode=balance-tcp other_config:lacp-time=fast

sudo ovs-vsctl add-bond sw02 lag02 sw02-link1 sw02-link2 \
  lacp=active bond_mode=balance-tcp other_config:lacp-time=fast