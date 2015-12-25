# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = 2

Vagrant.configure(VAGRANT_API_VERSION) do |config|
  config.vm.box = "zealic/debian-8-devenv"

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo gem install thor
  SHELL
end

# Load Vagrantfile.local to overwrite or extend default Vagrant configuration
load "Vagrantfile.local" if File.exist?("Vagrantfile.local")
