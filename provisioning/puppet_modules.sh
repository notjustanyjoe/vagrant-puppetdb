#!/bin/bash

# Install some initial puppet modules on Puppet Master server
/opt/puppetlabs/bin/puppet module install puppetlabs-puppetdb

# symlink manifest from Vagrant synced folder location
rm -rf /etc/puppetlabs/code/environments/production/manifests/site.pp
ln -s /vagrant/provisioning/site.pp /etc/puppetlabs/code/environments/production/manifests/