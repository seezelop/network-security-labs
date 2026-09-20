#!/usr/bin/env bash

set -e

sudo ovs-vsctl --may-exist add-br br-lab04-sw1
sudo ovs-vsctl --may-exist add-br br-lab04-sw2

sudo ip link set br-lab04-sw1 up
sudo ip link set br-lab04-sw2 up