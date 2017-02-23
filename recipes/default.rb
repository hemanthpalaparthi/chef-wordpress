#
# Cookbook:: wp
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

case node['platform']
when 'debian', 'ubuntu'
 execute 'apt-get update -y'
when 'redhat', 'centos', 'fedora','amazon'
  execute 'yum update -y'
end

mysql2_chef_gem 'default' do
  action :install
end

case node['platform']
when 'debian', 'ubuntu'
 package 'apache2'
when 'redhat', 'centos', 'fedora','amazon'
  package 'httpd'
end

package 'php'

include_recipe 'wp::mysql'
