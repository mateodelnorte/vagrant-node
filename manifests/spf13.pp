# This class installs spf13-vim-3
class spf13 {
  exec {
    'mk-spf13-dir':
    command => 'mkdir /home/vagrant/extras',
    onlyif => '[ ! -d /home/vagrant/extras ]'
  }
  exec {'download-spf13-vim-3':
    command => '/usr/bin/curl https://raw.github.com/spf13/spf13-vim/3.0/bootstrap.sh > /home/vagrant/extras/spf13-vim-3',
    creates => "/home/vagrant/extras/spf13-vim-3",
    require => [ Package['curl'], Exec['mk-spf13-dir'] ],
  }
  exec { chmod-spf13:
    command => 'chmod 777 /home/vagrant/extras/spf13-vim-3',
    require => Exec['download-spf13-vim-3'],
  }
}
