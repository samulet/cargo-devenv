class setenv {

  exec { "/usr/bin/aptitude update":
    require => Package["aptitude"];
  }

  package { sudo :
    ensure => present,
    require => Exec["apt_update"];
  }

  package { htop :
    ensure => present,
    require => Exec["apt_update"];
  }

  package { unzip :
    ensure => present,
    require => Exec["apt_update"];
  }

  package { make :
    ensure => present,
    require => Exec["apt_update"];
  }

  package { git-core :
    ensure => present,
    require => Exec["apt_update"];
  }

  package { vim :
    ensure => present,
    require => Exec["apt_update"];
  }

  package { aptitude : ensure => present }

  package { python-software-properties :
    ensure => present,
    require => Exec["/usr/bin/aptitude update"];
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
