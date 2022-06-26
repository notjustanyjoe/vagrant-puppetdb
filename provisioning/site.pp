node 'puppetdb.local' {
  class { 'puppetdb':
    postgres_version => '9.6',
    manage_firewall  => false,
    listen_address   => '0.0.0.0',
    ssl_listen_port  => '8082'
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

}
