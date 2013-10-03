#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# for use add-apt-repository command
package 'python-software-properties' do
    action :upgrade
end
bash'apt update' do
    code 'apt-get update'
end

bash 'add apt repository' do
    code <<EOC
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
add-apt-repository 'deb http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/5.5/ubuntu lucid main'
EOC
end

bash 'apt update' do
    code 'apt-get update'
end

package 'mariadb-server' do
    action :upgrade
end

