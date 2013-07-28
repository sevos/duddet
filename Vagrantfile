# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_plugin("vagrant-hostmanager")

class IPPool
  def initialize(network)
    @network = network
    @last_assigned = 1
  end

  def get_ip
    "#{prefix}#{@last_assigned+=1}"
  end

  def append_node(config)
    config.vm.network :private_network, ip: get_ip
  end

  private

  def prefix
    @network[/((\d{1,3}\.){3})0/,1]
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file  = "init.pp"
  end

  ip_pool = IPPool.new("192.168.118.0")

  config.vm.define :"duddet-bakery" do |config|
    ip_pool.append_node(config)
    config.vm.synced_folder "./images", "/home/vagrant/images", id: "vagrant-docker-images"
    config.vm.hostname = "duddet-bakery"

    config.vm.provider :virtualbox do |vb|
      # Don't boot with headless mode
      # vb.gui = true

      # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "768"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
  end

  # (0...1).each do |i|
  #   config.vm.define :"duddet-#{i}" do |config|
  #     ip_pool.append_node(config)
  #     config.vm.hostname = "duddet-#{i}"
  #   end
  # end
end
