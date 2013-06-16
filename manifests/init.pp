Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

exec { 'apt-get update':
  command => '/usr/bin/apt-get update --fix-missing',
}

include essentials
include spf13

$node_version = "v0.10.11"

class { 'nvm':
  node_version => $node_version,
}

class { 'phantomjs': 
  version => '1.9.1'
}