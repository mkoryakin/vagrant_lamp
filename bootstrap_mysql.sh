#!/usr/bin/env bash

cd /vagrant
apt-get update
apt-get install -y curl git vim
echo "192.168.33.10	vagrant1.example.com" >> /etc/hosts
echo "192.168.33.11	vagrant3.example.com" >> /etc/hosts
