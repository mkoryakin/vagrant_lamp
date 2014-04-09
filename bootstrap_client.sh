#!/usr/bin/env bash

cd /vagrant
apt-get update
apt-get install -y curl git vim
echo "192.168.33.10	vagrant1.example.com" >> /etc/hosts
echo "192.168.33.12	vagrant4.example.com" >> /etc/hosts
curl -L https://www.opscode.com/chef/install.sh | bash
chef-solo -v
