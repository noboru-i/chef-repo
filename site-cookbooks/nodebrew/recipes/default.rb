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

remote_file "/tmp/nodebrew" do
    source "http://git.io/nodebrew"
    mode 0777
end

script "setup" do
    interpreter "bash"
    user  $user
    group $group
    cwd   $home
    environment "HOME" => $home
    code "perl /tmp/nodebrew setup"
end

script "add path" do
    interpreter "bash"
    user  $user
    group $group
    cwd   $home
    code <<-EOC
echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> #{$home}/.bashrc
    EOC
    not_if "grep \"export PATH=$HOME/.nodebrew/current/bin:$PATH\" #{$home}/.bashrc", :user => $user
end

script "install-binary" do
    interpreter "bash"
    user  $user
    group $group
    cwd   $home
    environment "HOME" => $home
    code  <<-EOC
#{$path}/nodebrew install-binary stable
if [ $? -eq 1 ]; then
    exit 0
fi
    EOC
end

script "use" do
    interpreter "bash"
    user  $user
    group $group
    cwd   $home
    environment "HOME" => $home
    code  "#{$path}/nodebrew use stable"
end

