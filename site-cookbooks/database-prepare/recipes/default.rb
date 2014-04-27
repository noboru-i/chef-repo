#
# Cookbook Name:: database-prepare
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

database_type = node[:database][:type]

if database_type == 'mysql'
    package 'mysql-client-5.5' do
        action :upgrade
    end

    package 'libmysqlclient-dev' do
        action :upgrade
    end

    template '/tmp/mysql-schema.sql' do
        source 'mysql-schema.sql.erb'
    end

    bash 'apply schema' do
        code "mysql -uroot -h#{node[:database][:host]} #{"-p" + node[:database][:password] if node[:database][:host] != 'localhost'} < /tmp/mysql-schema.sql"
    end
end
