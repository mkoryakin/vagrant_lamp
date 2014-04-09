#
# Cookbook Name:: lampapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "lampapp::mysql_server"
include_recipe "lampapp::web"
