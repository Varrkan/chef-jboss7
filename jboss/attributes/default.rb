
default[:jboss][:version] = '7.1.1.Final'
default[:jboss][:install_path] = '/opt'
default[:jboss][:url] = 'http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip'
default[:jboss][:filename] = "jboss-as-#{node[:jboss][:version]}"
default[:jboss][:package_url] = "#{node[:jboss][:url]}/#{node[:jboss][:filename]}.zip"
default[:jboss][:checksum] = '175c92545454f4e7270821f4b8326c4e'
default[:jboss][:log_dir] = "/var/log/jboss-as/#{node[:jboss][:version]}"
default[:jboss][:jboss_user] = 'jboss-as'
default[:jboss][:jboss_group] = 'jboss'
default[:jboss][:admin_user] = 'admin'
default[:jboss][:admin_passwd] = 'password'
default[:jboss][:startup_wait] = 30
default[:jboss][:shutdown_wait] = 30
default[:jboss][:java_opts] = '-Xms1303m -Xmx1303m -XX:MaxPermSize=256m -Djava.net.preferIPv4Stack=true'
default[:jboss][:preserve_java_opts] = false
default[:jboss][:port_offset] = 0
default[:jboss][:app_url] = #{node[:jboss][:app]}
default[:jboss][:app_name] = "testweb"
default[:jboss][:app_packge] = "#{node[:jboss][:app_url]}/#{node[:jboss][:app_name]}.zip"