# Encoding: utf-8
#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2014, Mariani Lucas
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

log "log" do
level :info
action :write
end

package 'install_unzip' do
  package_name 'unzip'
  action :install
end

user node[:jboss][:jboss_user] do
  action :create
end

group node[:jboss][:jboss_group] do
  action :create
  members node[:jboss][:jboss_user]
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:jboss][:filename]}.zip" do
  source node[:jboss][:url]
  checksum node[:jboss][:checksum]
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

execute 'jboss_extract' do
  user 'root'
  cwd Chef::Config[:file_cache_path]
  command "unzip  #{node[:jboss][:filename]}.zip -d /opt/"
  not_if {::File.exists?("/opt/jboss-as-7.1.1.Final")}
  action :run
end

directory '/etc/jboss-as' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file "jboss-as.conf" do
path "/etc/jboss-as/jboss-as.conf"
owner 'root'
group 'root'
end

cookbook_file "jboss-as-standalone.sh" do
path "/etc/init.d/jboss"
owner 'root'
group 'root'
mode 0755
end

execute 'jboss_owner' do
  user 'root'
  cwd node[:jboss][:install_path]
  command "chown -R #{node[:jboss][:jboss_user]}. #{node[:jboss][:install_path]}"
  action :run
end

directory '/etc/jboss-as' do
  owner node[:jboss][:jboss_user]
  group node[:jboss][:jboss_group]
  mode '0755'
end

directory '/var/run/jboss-as' do
  owner node[:jboss][:jboss_user]
  group node[:jboss][:jboss_group]
  mode '0755'
end

directory '/var/log/jboss-as' do
  owner node[:jboss][:jboss_user]
  group node[:jboss][:jboss_group]
  mode '0755'
end

directory node[:jboss][:log_dir] do
  recursive true
  owner node[:jboss][:jboss_user]
  group node[:jboss][:jboss_group]
  mode '0775'
end

service "jboss" do
 supports :restart => true, :start => true, :stop => true, :reload => true
action [:start]
end

#directory "#{node[:jboss][:install_path]}/#{node[:jboss][:application]}/standalone/log" do
 # recursive true
 # action :delete
 # not_if { node[:jboss][:log_dir] == "#{node[:jboss][:install_path]}/#{node[:jboss][:application]}/standalone/log" }
 # not_if "test -h #{node[:jboss][:install_path]}/#{node[:jboss][:application]}/standalone/log"
#end

#link "#{node[:jboss][:install_path]}/#{node[:jboss][:application]}/standalone/log" do
 # to node[:jboss][:log_dir]
 # owner node[:jboss][:jboss_user]
 # group node[:jboss][:jboss_group]
 # not_if { node[:jboss][:log_dir] == "#{node[:jboss][:install_path]}/#{node[:jboss][:application]}/standalone/log" }
 # not_if "test -h #{node[:jboss][:install_path]}/#{node[:jboss][:application]}/standalone/log"
#end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:jboss][:app_name]}.zip" do
  source node[:jboss][:app_url]
  owner 'root'
  group 'root'
  mode 00755
  action :create
  end

execute 'app_deploy' do
  user 'root'
  cwd Chef::Config[:file_cache_path]
  command "unzip  #{node[:jboss][:app_name]}.zip -d /opt/jboss-as-7.1.1.Final/standalone/deployments/"
  not_if {::File.exists?("/opt/jboss-as-7.1.1.Final/standalone/deployments/testweb")}
  action :run
end

execute 'premissions' do
  cwd node[:jboss][:install_path]
  command "chown -R #{node[:jboss][:jboss_user]}. #{node[:jboss][:install_path]}"
end

service "jboss" do
action [:restart]
end
