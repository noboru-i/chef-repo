# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "template"

  config.vm.network :private_network, ip: "192.168.50.11"
#  config.vm.network :forwarded_port, guest: 22, host: 2224
#  config.vm.synced_folder "../web", "/srv/web/current", nfs: true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--cpus", 2]
  end

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./site-cookbooks"
    chef.log_level = :debug

    chef.environments_path = "./environments"
    chef.environment = "local"

    chef.json = {
      # :nginx => {
      #   :port => 80
      # },
      # :nodebrew => {
      #   :user => "vagrant"
      # },
      :rbenv => {
        :user => "vagrant",
        :version => "2.0.0-p451"
      }
    }
    chef.add_recipe("dev-tools")
#    chef.add_recipe("nginx")
#    chef.add_recipe("jenkins")
#    chef.add_recipe("nodebrew")
#    chef.add_recipe("rbenv")
#    chef.add_recipe("oracle-java7")
#    chef.add_recipe("mariadb")
#    chef.add_recipe("jetty")
    chef.add_recipe("mysql")
  end
end
