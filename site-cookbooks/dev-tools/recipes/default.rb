#
# Cookbook Name:: dev-tools
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "apt update" do
    code 'apt-get update'
end

%w(curl git-core vim unzip).each do |pkg|
    package pkg
end
