#
# Cookbook Name:: lampapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "mysql::client"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"

apache_site "default" do
  enable false
end

sites = data_bag("wp-sites")

db_hosts = search(:node, 'role:lampapp-mysql')

if db_hosts.empty?
  db_host = 'localhost'
else
  begin
    db_host = db_hosts[0].cloud.private_ips[0]
  rescue NoMethodError => e
    db_host = db_hosts[0][:network][:interfaces][:eth1][:addresses].keys[1]
  end
end

sites.each do |site|
  opts = data_bag_item("wp-sites", site)

  wordpress_site opts["host"] do
    path "/var/www/" + opts["host"]
    db_host db_host
    database opts["database"]
    db_username opts["db_username"]
    db_password opts["db_password"]
    template "site.conf.erb"
  end
end
