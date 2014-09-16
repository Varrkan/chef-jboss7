#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, EPAM
#
# All rights reserved - Do Not Redistribute
#
web "web_servers" do
provider "#{node[:web_server_type]}"
action :install
end

web "web_servers" do
provider "#{node[:web_server_type]}"
action :start
end

web "web_servers" do
provider "#{node[:web_server_type]}"
action :stop
end

web "web_servers" do
provider "#{node[:web_server_type]}"
action :restart
end

web "web_servers" do
provider "#{node[:web_server_type]}"
action :reload
end


