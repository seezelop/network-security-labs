#!/usr/bin/env bash

set -e

sudo ovs-vsctl --if-exists del-br sw01
sudo ovs-vsctl --if-exists del-br sw02