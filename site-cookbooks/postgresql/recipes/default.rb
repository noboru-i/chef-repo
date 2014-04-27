#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'add repository' do
    command <<-EOC
        echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list
        wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
        apt-get update
    EOC
    not_if "cat /etc/apt/sources.list | grep -c http://apt.postgresql.org/pub/repos/apt/"
end

%w(postgresql-9.3 postgresql-9.3-postgis-2.1 postgresql-contrib).each do |pkg|
    package pkg do
        action :upgrade
    end
end

service 'postgresql' do
    supports :status => true, :restart => true
    action [ :enable, :start ]
end
