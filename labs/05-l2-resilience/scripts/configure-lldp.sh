#!/usr/bin/env bash

set -e

sudo ovs-vsctl set Interface sw01-link1 lldp:enable=true
sudo ovs-vsctl set Interface sw01-link2 lldp:enable=true
sudo ovs-vsctl set Interface sw02-link1 lldp:enable=true
sudo ovs-vsctl set Interface sw02-link2 lldp:enable=true