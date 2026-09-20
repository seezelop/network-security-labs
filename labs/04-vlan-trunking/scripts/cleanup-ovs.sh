#!/usr/bin/env bash

set -e

sudo ovs-vsctl --if-exists del-br br-lab04-sw1
sudo ovs-vsctl --if-exists del-br br-lab04-sw2