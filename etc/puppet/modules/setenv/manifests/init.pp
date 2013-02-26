class setenv {

  exec { "/usr/bin/aptitude update":
    require => Package["aptitude"];
  }

  exec { "/usr/bin/apt-get update":
    command => "/usr/bin/apt-get update";
  }

  package { sudo :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
  }

  package { htop :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
  }

  package { unzip :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
  }

  package { git-core :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
  }

  package { vim :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
  }

  package { aptitude : ensure => present }

  package { "apache2.2-bin" :
    ensure => absent,
    before => Package["nginx"],
    require => Package["php5-fpm"],
  }

  package { fail2ban :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
  }

  package { python-software-properties :
    ensure => present,
    require => Exec["/usr/bin/apt-get update"];
  }

  exec { "/usr/sbin/update-alternatives --set editor /usr/bin/vim.basic":
    unless => "/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic",
    require => Package["aptitude", "vim"];
  }

  file { "/etc/environment":
    ensure => present,
    content => template("setenv/etc/environment.erb"),
  }

  file { "/etc/hosts":
    ensure => present,
    content => template("setenv/etc/hosts.erb"),
  }

  file { "/etc/hostname":
    ensure => present,
    content => "cargo.local",
  }

}
