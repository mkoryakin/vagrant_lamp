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
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
include_recipe "database::mysql"

apache_site "default" do
  enable false
end

mysql_service 'default' do
  version '5.5'
end

mysql_database node['lampapp']['database'] do
  connection ({:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

mysql_database_user node['lampapp']['db_username'] do
  connection ({:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']})
  password node['lampapp']['db_password']
  database_name node['lampapp']['database']
  privileges [:select,:update,:insert,:create,:delete]
  action :grant
end

wordpress_latest = Chef::Config[:file_cache_path] + "/wordpress-latest.tar.gz"

remote_file wordpress_latest do
  source "http://wordpress.org/latest.tar.gz"
  mode "0644"
end

directory node["lampapp"]["path"] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "untar-wordpress" do
  cwd node['lampapp']['path']
  command "tar --strip-components 1 -xzf " + wordpress_latest
  creates node['lampapp']['path'] + "/wp-settings.php"
end

wp_secrets = Chef::Config[:file_cache_path] + '/wp-secrets.php'

if File.exist?(wp_secrets)
  salt_data = File.read(wp_secrets)
else
  require 'open-uri'
  salt_data = open('https://api.wordpress.org/secret-key/1.1/salt/').read
  open(wp_secrets, 'wb') do |file|
    file << salt_data
  end
end

template node['lampapp']['path'] + '/wp-config.php' do
  source 'wp-config.php.erb'
  mode 0755
  owner 'root'
  group 'root'
  variables(
    :database        => node['lampapp']['database'],
    :user            => node['lampapp']['db_username'],
    :password        => node['lampapp']['db_password'],
    :wp_secrets      => salt_data)
end

web_app 'lampapp' do
  template 'site.conf.erb'
  docroot node['lampapp']['path']
  server_name node['lampapp']['server_name']
end
