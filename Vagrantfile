# -*- mode: ruby -*-
# vi: set ft=ruby :

# --------------------------
# Vagrant Configuration File
# Ubuntu 17.10
# --------------------------
#
# Ralph Wiedemeier <ralph@framefactory.ch>
# (c) 2018 Frame Factory GmbH

# Shell provisioning during first-time setup
$provisioning = <<-PROVISIONING
  apt-get install -y dos2unix
  dos2unix /var/provisioning/**/*
  pushd /var/provisioning
  sh ubuntu-base.sh
  sh ubuntu-samba.sh
  sh ubuntu-node.sh
  #sh ubuntu-caddy.sh
  sh ubuntu-aliases.sh
PROVISIONING

Vagrant.configure("2") do |config|

  # Base Vagrant box
  config.vm.box = "bento/ubuntu-17.10"

  # Disable automatic box update checking (not recommended).
  # config.vm.box_check_update = false

  # Virtual machine hostname
  config.vm.hostname = "lightbox"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "10.0.0.10"
  # config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
  # config.vm.network "forwarded_port", guest: 80, host: 8080, id: "http"
  # example: only allow access via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Shared folders: host path to actual folder, guest path to mount point.
  config.vm.synced_folder "shared/", "/var/shared",
    owner: "vagrant",
    group: "vagrant",
    mount_options: [ "dmode=777,fmode=777" ]
    
  config.vm.synced_folder "provisioning/", "/var/provisioning",
    owner: "vagrant",
    group: "vagrant",
    mount_options: [ "dmode=777,fmode=777" ]
    
  # Disable default shared folder
  config.vm.synced_folder ".", "/vagrant",
    disabled: true
  
  # Provider-specific configuration
  config.vm.provider "vmware-fusion" do |vb|
    vb.name = "Lightbox"
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Lightbox"
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Shell provisioning
  config.vm.provision "shell",
    inline: $provisioning,
    privileged: true

  # Docker provisioning
  config.vm.provision "docker" do |docker|
    #docker.pull_images "image:version"
  end 
end
