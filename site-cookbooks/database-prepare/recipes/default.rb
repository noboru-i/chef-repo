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

if database_type == 'postgresql'
    package 'postgresql-client-common' do
        action :upgrade
    end

    execute "create-role" do
        exists = <<-EOH
            su - postgres -c "psql -c\\"SELECT * FROM pg_user WHERE usename='#{node[:database][:user]}'\\" | grep -c #{node[:database][:user]}"
        EOH
        command <<-EOC
            su - postgres -c "psql -c\\"CREATE ROLE #{node[:database][:user]} WITH LOGIN PASSWORD '#{node[:database][:password]}';\\""
        EOC
        not_if exists
    end

    execute "create-database" do
        exists = <<-EOH
            su - postgres -c "psql -c\\"SELECT * FROM pg_database WHERE datname = '#{node[:database][:name]}'\\" | grep -c #{node[:database][:name]}"
        EOH
        command <<-EOC
            su - postgres -c "psql -c\\"CREATE DATABASE #{node[:database][:name]} OWNER #{node[:database][:user]} ENCODING 'UTF8' LC_CTYPE 'en_US.UTF-8' LC_COLLATE 'en_US.UTF-8' TEMPLATE template0;\\""
            su - postgres -c "psql -d #{node[:database][:name]} -f /usr/share/postgresql/9.3/extension/postgis--2.1.2.sql"
        EOC
        not_if exists
    end
end
