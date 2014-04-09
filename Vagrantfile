# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "server" do |server|
    server.vm.box = "hashicorp/precise64"
    server.vm.hostname = "vagrant1.example.com"
    server.vm.provision :shell, :path => "bootstrap_server.sh"
    server.vm.network "private_network", ip: "192.168.33.10"
    server.ssh.forward_agent = true

    server.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end

  config.vm.define "client" do |client|
    client.vm.box = "chef/debian-7.4"
    client.vm.hostname = "vagrant3.example.com"
    client.vm.provision :shell, :path => "bootstrap_client.sh"
    client.vm.network "private_network", ip: "192.168.33.11"
    client.ssh.forward_agent = true

    client.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end

    client.vm.provision "chef_client" do |chef|
      chef.chef_server_url = "https://192.168.33.10:443"
      chef.validation_key_path = "chef-validator.pem"
      chef.add_role "lampapp-web"
    end
  end

  config.vm.define "mysql" do |mysql|
    mysql.vm.box = "chef/debian-7.4"
    mysql.vm.hostname = "vagrant4.example.com"
    mysql.vm.provision :shell, :path => "bootstrap_mysql.sh"
    mysql.vm.network "private_network", ip: "192.168.33.12"
    mysql.ssh.forward_agent = true

    mysql.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end
end
