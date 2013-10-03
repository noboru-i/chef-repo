#
# Cookbook Name:: oracle-java7
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# for use add-apt0repository command
package 'python-software-properties' do
    action :upgrade
end
bash'apt update' do
    code 'apt-get update'
end

bash 'add apt repository' do
    code 'add-apt-repository ppa:webupd8team/java'
end

bash 'apt update' do
    code 'apt-get update'
end

bash 'accept-license' do
    code "echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
end

package 'oracle-java7-installer' do
    action :upgrade
end

