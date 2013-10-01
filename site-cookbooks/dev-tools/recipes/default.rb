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

%w(curl git-core vim).each do |pkg|
    package pkg
end

# bash "set dotfiles" do
#     user 'vagrant'
#     cwd '/home/vagrant'
#     code "curl https://raw.github.com/gist/5901503 | bash"
#     creates '/home/vagrant/.dotfiles'
# end

