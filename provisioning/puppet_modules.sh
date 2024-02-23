#!/bin/bash

# Install some initial puppet modules on Puppet Master server
#/opt/puppetlabs/bin/puppet module upgrade puppetlabs-stdlib --version 9.4.1
/opt/puppetlabs/bin/puppet module install puppetlabs-puppetdb --version 7.13.0
/opt/puppetlabs/bin/puppet module install puppetlabs-docker   --version 7.0.0
# symlink manifest from Vagrant synced folder location
rm -rf /etc/puppetlabs/code/environments/production/manifests/site.pp
ln -s /vagrant/provisioning/site.pp /etc/puppetlabs/code/environments/production/manifests/