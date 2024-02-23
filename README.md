# Vagrant Puppetdb

Vagrant config for testing 3 node setup for puppet/puppetdb/workstation.

## Set Up

Install Vagrant  
Install Virtualbox

## Usage

Run this to bring everything up initially:
`vagrant up`
This will bring up the machines and do an initial provisioning with PuppetDB running the puppetdb module install from the puppet server.  
You will next need to log into the puppet server and run `puppet agent -t` so it configures itself to talk to puppetdb. You can then log  
into the workstation to test that everything is working and run `puppet agent -t`

> if all works as expected, the workstation vm should have a test-user created with a home directory. You should also be able to open a browser on the host machine and go to http://localhost:8088 for the puppetboard.
> TL;DR

1. `vagrant up`
2. `vagrant ssh puppet`
3. `sudo -i`
4. `puppet agent -t`
5. `exit` twice
6. `vagrant ssh workstation`
7. `sudo -i`
8. `puppet agent -t`

## Provisioning

Ansible_local (installed on vm) is used during vagrant provisioning to bootstrap the nodes with puppet6  
repositories and initial configuration.

## Upgrade testing from puppet 6 --> 7 with puppetdb on 9.6 --> 11

1. upgrade client puppet agents to 7
   1. for this example, ensure puppet_version is set to puppet7 at top of Vagrantfile
      1. run `vagrant provision workstation`
      2. `vagrant ssh workstation`
      3. `puppet --version`
      4. `puppet agent -t`
2. upgrade puppetdb postresql to 11
   1. rename site.pp to site_puppet6.pp and site_puppet7.pp to site.pp. This will install postgresql 11 and manage the repo.
   2. vagrant ssh puppetdb
   3. sudo -i
   4. systemctl disable postgresql-9.6.service --now
   5. disable postgresql 9.6 repo
   6. puppet agent -t
   7. for this example, ensure puppet_version is set to puppet7 at top of Vagrantfile (change repo to puppet7)
      1. `vagrant provision puppetdb` (yum update -y)
      2. `puppet --version`
      3. `puppet agent -t`
3. upgrade puppet server to 7
   1. for this example, ensure puppet_version is set to puppet7 at top of Vagrantfile (change repo to puppet7)
      1. `vagrant provision puppet` (yum update -y)
      2. `puppet --version`
      3. `puppetserver --version`
      4. `puppet agent -t`
4. upgrade puppet agent's on workstations
   1. for this example, ensure puppet_version is set to puppet7 at top of Vagrantfile (change repo to puppet7)
      1. `vagrant provision workstation` (yum update -y)
      2. `puppet --version`
      3. `puppet agent -t`

## overview of steps

