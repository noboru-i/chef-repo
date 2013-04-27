#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "install jenkins" do
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant'
  environment "HOME" => '/home/vagrant'
  code <<-EOC
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
  EOC
  creates "/etc/apt/sources.list.d/jenkins.list"
end

package "jenkins" do
  action :upgrade
end

service "jenkins" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "jenkins" do
  path "/etc/nginx/sites-enabled/jenkins"
  source "jenkins.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[nginx]'
end

