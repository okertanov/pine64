#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

locale-gen en_US.UTF-8

apt-get -y update
apt-get -y remove --purge ureadahead
apt-get -y autoremove
apt-get clean

