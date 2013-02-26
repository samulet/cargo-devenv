class site::cargo {

  file { "/etc/nginx/sites-available/cargo.local":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/site/etc/nginx/sites-available/cargo.local",
      require => Package["nginx"],
  }

  nginx::sites::site { "cargo.local" : ensure => present }
}