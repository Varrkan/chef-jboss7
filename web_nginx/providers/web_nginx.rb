action :install do
remote_file "#{Chef::Config[:file_cache_path]}/nginx_srv.rpm" do
source "http://nginx.org/packages/rhel/6/noarch/RPMS/nginx-release-rhel-6-0.el6.ngx.noarch.rpm"
end
package "nginx_srv" do
source "#{Chef::Config[:file_cache_path]}/nginx_srv.rpm"
action :install
end

package "nginx" do
action :install
end
end

action :stop do
service "nginx" do
action :stop
end
end

action :start do
service "nginx" do
action :start
end
end

action :restart do
service "nginx" do
action :restart
end
end

action :reload do
service "nginx" do
action :reload
end
end
