class nginx::install {
  package { "nginx":
    name   => "nginx",
    ensure => present,
    require => Exec["apt_update"],
  }

  service { "nginx":
    name => "nginx",
    enable => true,
    ensure => running,
    hasrestart => true,
    require => Package["nginx"],
  }

  exec { "force-reload-nginx":
    command => "/etc/init.d/nginx force-reload",
    refreshonly => true,
    before => Service["nginx"],
  }
}
