#!/usr/bin/env bash

set -e

sudo ovs-vsctl --may-exist add-br sw01
sudo ovs-vsctl --may-exist add-br sw02

sudo ip link set sw01 up
sudo ip link set sw02 up
