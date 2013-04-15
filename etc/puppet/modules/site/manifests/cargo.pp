class site::cargo {

  file { "/etc/nginx/sites-available/cargo":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 644,
      content  => template("site/nginx/sites-available/cargo.erb"),
      require => Package["nginx"],
  }

  nginx::sites::site { "cargo" : ensure => present }
}