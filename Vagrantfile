# -*- mode: ruby -*-
# vi: set ft=ruby :
puppet_version = "puppet7" 

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.define "puppet" do |puppet|
    puppet.vm.box = "bento/rockylinux-8"
    puppet.vm.hostname = "puppet.local"
    puppet.vm.network :private_network, ip: "192.168.56.10"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end 
    puppet.vm.provision :ansible_local do |ansible|
      ansible.galaxy_role_file = "provisioning/requirements.yml"
      ansible.playbook = "provisioning/puppetserver_install.yml"
      ansible.config_file = "provisioning/ansible.cfg"
      ansible.inventory_path = "provisioning/inventory"
      ansible.limit = "all"
      ansible.extra_vars = { puppet_yum_rpm: "https://yum.puppet.com/#{puppet_version}-release-el-{{ ansible_distribution_major_version }}.noarch.rpm" }
    puppet.vm.provision :shell, path: "provisioning/puppet_modules.sh"
    # DNS Hosts setup on all machines 
    puppet.vm.provision :hosts, :sync_hosts => true
    end
  end
  config.vm.define "puppetdb" do |puppetdb|
    puppetdb.vm.box = "bento/rockylinux-8"
    puppetdb.vm.hostname = "puppetdb.local"
    puppetdb.vm.network :private_network, ip: "192.168.56.11"
    puppetdb.vm.network :forwarded_port, guest: 8088, host: 8088
    puppetdb.vm.provision :ansible_local do |ansible|
      ansible.galaxy_role_file = "provisioning/requirements.yml"
      ansible.playbook = "provisioning/puppetdb_install.yml"
      ansible.config_file = "provisioning/ansible.cfg"
      ansible.inventory_path = "provisioning/inventory"
      ansible.limit = "all"
      ansible.extra_vars = { puppet_yum_rpm: "https://yum.puppet.com/#{puppet_version}-release-el-{{ ansible_distribution_major_version }}.noarch.rpm" }
    end
    # DNS Hosts setup on all machines 
    puppetdb.vm.provision :hosts, :sync_hosts => true
    puppetdb.vm.provision :puppet_server do |puppet_agent|
      puppet_agent.options = "--test"
    end
  end
  config.vm.define "workstation" do |workstation|
    workstation.vm.box = "bento/rockylinux-8"
    workstation.vm.hostname = "workstation.local"
    workstation.vm.network :private_network, ip: "192.168.56.12"
    workstation.vm.provision :ansible_local do |ansible|
      ansible.galaxy_role_file = "provisioning/requirements.yml"
      ansible.playbook = "provisioning/puppet_install.yml"
      ansible.config_file = "provisioning/ansible.cfg"
      ansible.inventory_path = "provisioning/inventory"
      ansible.limit = "all"
      ansible.extra_vars = { puppet_yum_rpm: "https://yum.puppet.com/#{puppet_version}-release-el-{{ ansible_distribution_major_version }}.noarch.rpm" }
    end
    # DNS Hosts setup on all machines 
    workstation.vm.provision :hosts, :sync_hosts => true
  end

end
