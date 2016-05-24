# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = 2

Vagrant.configure(VAGRANT_API_VERSION) do |config|
  config.vm.box = "zealic/debian-8-devenv"

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "shell", inline: <<-SHELL
  SHELL
end

# Load Vagrantfile.local to overwrite or extend default Vagrant configuration
load "Vagrantfile.local" if File.exist?("Vagrantfile.local")
