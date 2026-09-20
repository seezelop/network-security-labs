#!/usr/bin/env bash

set -e

sudo ovs-vsctl --may-exist add-br sw01
sudo ip link set sw01 up


