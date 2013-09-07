#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

home_dir = '/home/vagrant'
version = '2.0.0-p247'

package 'build-essential'

git "#{home_dir}/.rbenv" do
    repository 'https://github.com/sstephenson/rbenv.git'
    reference 'master'
    action :checkout
    user 'vagrant'
    group 'vagrant'
end

directory "#{home_dir}/.rbenv/plugins" do
    owner 'vagrant'
    group 'vagrant'
    action :create
end

git "#{home_dir}/.rbenv/plugins/ruby-build" do
    repository 'https://github.com/sstephenson/ruby-build.git'
    reference 'master'
    action :checkout
    user 'vagrant'
    group 'vagrant'
end

script 'export path' do
    interpreter 'bash'
    not_if 'which rbenv'
    user 'vagrant'
    group 'vagrant'
    code <<-EOC
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> #{home_dir}/.profile
        echo 'eval "$(rbenv init -)"' >> #{home_dir}/.profile
    EOC
end

script 'install ruby' do
    interpreter 'bash'
    user 'vagrant'
    group 'vagrant'
    not_if "#{home_dir}/.rbenv/bin/rbenv versions | grep #{version}"
    environment 'HOME' => home_dir
    code <<-EOC
        eval "$(rbenv init -)"
        #{home_dir}/.rbenv/bin/rbenv install #{version}
        #{home_dir}/.rbenv/bin/rbenv rehash
        #{home_dir}/.rbenv/bin/rbenv global #{version}
    EOC
end
