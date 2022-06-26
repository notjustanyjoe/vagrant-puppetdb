# Vagrant Puppetdb

Vagrant config for testing 3 node setup for puppet/puppetdb/workstation.

## Set Up

Install Vagrant
Install Virtualbox

## Usage

vagrant up

## Provisioning

Ansible_local (installed on vm) is used during vagrant provisioning to bootstrap the nodes with puppet6  
repositories and initial configuration.
