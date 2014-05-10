#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user = node[:rbenv][:user]
group = node[:rbenv][:group] || user
home_dir = "/home/#{user}"
version = node[:rbenv][:version]

package 'build-essential'

git "#{home_dir}/.rbenv" do
    repository 'https://github.com/sstephenson/rbenv.git'
    reference 'master'
    action :checkout
    user user
    group group
end

directory "#{home_dir}/.rbenv/plugins" do
    owner user
    group group
    action :create
end

git "#{home_dir}/.rbenv/plugins/ruby-build" do
    repository 'https://github.com/sstephenson/ruby-build.git'
    reference 'master'
    action :checkout
    user user
    group group
end

bash 'export path' do
    user user
    group group
    code <<-EOC
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> #{home_dir}/.profile
        echo 'eval "$(rbenv init -)"' >> #{home_dir}/.profile
    EOC
    not_if "cat #{home_dir}/.bash_profile | grep '$HOME/.rbenv/bin:$PATH'"
end

bash 'install ruby' do
    user user
    group group
    environment 'HOME' => home_dir
    code <<-EOC
        eval "$(rbenv init -)"
        #{home_dir}/.rbenv/bin/rbenv install #{version}
        #{home_dir}/.rbenv/bin/rbenv rehash
        #{home_dir}/.rbenv/bin/rbenv global #{version}
    EOC
    not_if "#{home_dir}/.rbenv/bin/rbenv versions | grep #{version}"
end
