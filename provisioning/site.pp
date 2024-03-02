node 'puppetdb.local' {
  class { 'puppetdb':
    manage_package_repo => false,
    postgres_version => '12',
    manage_firewall  => false,
    listen_address   => '0.0.0.0',
    ssl_listen_port  => '8082'
  }
  include docker

  docker::image { 'ghcr.io/voxpupuli/puppetboard': }

  docker::run { 'puppetboard':
    image => 'ghcr.io/voxpupuli/puppetboard',
    env   => [
      'PUPPETDB_HOST=127.0.0.1',
      'PUPPETDB_PORT=8080',
      'PUPPETBOARD_PORT=8088',
      'SECRET_KEY=de5c58816a25f9959330b752671ac6cc9d24ab43b969a1f06e7c25dc2d1f42ae',
    ],
    net   => 'host',
  }
}
node 'puppet.local' {
  class { 'puppetdb::master::config':
    puppetdb_server => 'puppetdb.local',
    puppetdb_port   => '8082',
    manage_report_processor => true,
    enable_reports => true
  }
}

node default {
  user { 'test-user':
    ensure     => present,
    uid        => '1900',
    shell      => '/bin/bash',
    home       => '/home/test-user',
    managehome => true,
  }
}
