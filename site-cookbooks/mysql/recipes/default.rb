#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'mysql-server-5.5' do
    action :upgrade
end

service 'mysql' do
    supports :status => true, :restart => true
    action [ :enable, :start ]
end

template 'character_set.cnf' do
    path '/etc/mysql/conf.d/character_set.cnf'
    owner 'root'
    group 'root'
    mode 0644
    notifies :restart, 'service[mysql]'
end
