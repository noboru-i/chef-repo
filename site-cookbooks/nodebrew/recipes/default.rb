#
# Cookbook Name:: nodebrew
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

$user  = node['nodebrew']['user']
$group = node['nodebrew']['group'] || $user
$home  = node['nodebrew']['home'] || "/home/#{$user}"
$path  = "#{$home}/.nodebrew/current/bin"

package 'curl'

bash "setup" do
    user  $user
    group $group
    cwd   $home
    environment "HOME" => $home
    code <<-EOC
        curl -L git.io/nodebrew | perl - setup
        echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> #{$home}/.bashrc
    EOC
    not_if "which nodebrew"
end

bash "install-binary and use" do
    user  $user
    group $group
    cwd   $home
    environment "HOME" => $home
    code  <<-EOC
        #{$path}/nodebrew install-binary stable
        #{$path}/nodebrew use stable
    EOC
    not_if "which node"
end
