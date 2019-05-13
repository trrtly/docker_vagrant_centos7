# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "epwk-centos7"
  config.vm.box_check_update = false
  config.vm.network "private_network", ip: "192.168.50.100"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/data", create: true, type: "virtualbox"
  config.vm.hostname = "epwkdev"
  config.vm.define "epwkdev"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 1
    vb.name = "epwkdev"
  end
  config.vm.provision "shell", path: "bootstrap.sh"
end
