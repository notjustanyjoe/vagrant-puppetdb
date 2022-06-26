# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "geerlingguy/centos7"
    puppet.vm.hostname = "puppet.local"
    puppet.vm.network :private_network, ip: "192.168.0.10"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end 
    puppet.vm.provision :ansible_local do |ansible|
      ansible.galaxy_role_file = "provisioning/requirements.yml"
      ansible.playbook = "provisioning/puppetserver_install.yml"
      ansible.config_file = "provisioning/ansible.cfg"
      ansible.inventory_path = "provisioning/inventory"
      ansible.limit = "all"
    puppet.vm.provision :shell, path: "provisioning/puppet_modules.sh"
    # DNS Hosts setup on all machines 
    puppet.vm.provision :hosts, :sync_hosts => true
    end
  end
  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.box = "geerlingguy/centos7"
    puppetdb.vm.hostname = "puppetdb.local"
    puppetdb.vm.network :private_network, ip: "192.168.0.11"
    puppetdb.vm.provision :ansible_local do |ansible|
      ansible.galaxy_role_file = "provisioning/requirements.yml"
      ansible.playbook = "provisioning/puppetdb_install.yml"
      ansible.config_file = "provisioning/ansible.cfg"
      ansible.inventory_path = "provisioning/inventory"
      ansible.limit = "all"
    end
    # DNS Hosts setup on all machines 
    puppetdb.vm.provision :hosts, :sync_hosts => true
  end
  config.vm.define "workstation" do |workstation|
    workstation.vm.box = "geerlingguy/centos7"
    workstation.vm.hostname = "workstation.local"
    workstation.vm.network :private_network, ip: "192.168.0.12"
    workstation.vm.provision :ansible_local do |ansible|
      ansible.galaxy_role_file = "provisioning/requirements.yml"
      ansible.playbook = "provisioning/puppet_install.yml"
      ansible.config_file = "provisioning/ansible.cfg"
      ansible.inventory_path = "provisioning/inventory"
      ansible.limit = "all"
    end
    # DNS Hosts setup on all machines 
    workstation.vm.provision :hosts, :sync_hosts => true
  end

end
