#
# Cookbook Name:: jetty
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'jetty' do
    shell '/bin/false'
end

group 'jetty' do
    members ['jetty']
    action :create
end

bash 'download jetty' do
    cwd '/opt'
    code <<EOC
wget "http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.0.5.v20130815/jetty-distribution-9.0.5.v20130815.tar.gz"
tar zxvf jetty-distribution-9.0.5.v20130815.tar.gz
mv jetty-distribution-9.0.5.v20130815 jetty
chown -R jetty:jetty /opt/jetty
EOC
    not_if { File.exists?('/opt/jetty/bin') }
end

bash 'copy script' do
    code 'cp /opt/jetty/bin/jetty.sh /etc/init.d/jetty'
    only_if { !File.exists?('/etc/init.d/jetty') }
end

template '/etc/default/jetty' do
    owner 'root'
    source 'jetty.erb'
end

service 'jetty' do
    action [:enable, :start]
end

