class setenv {
  file { "/etc/environment":
    ensure => present,
    content => template("setenv/etc/environment.erb"),
  }

  file { "/etc/hosts":
    ensure => present,
    content => template("setenv/etc/hosts.erb"),
  }

}
