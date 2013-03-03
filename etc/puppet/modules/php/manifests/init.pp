class php {

  apt::ppa { 'ppa:ondrej/php5': }

  package {
    "php5-cli":
      ensure => present,
      require => Apt::Ppa['ppa:ondrej/php5'];
    "curl":
      ensure => present;
    "xml-core":
      ensure => present;
    "php5-curl":
      ensure => present,
      require => Apt::Ppa['ppa:ondrej/php5'];
    "php5-fpm":
      ensure => present,
      require => Package["php5-cli"];
    "php5-dev":
      ensure => present,
      require => Package["php5-cli"];
    "php-pear":
      ensure => present,
      require => Package["php5-cli"];
    "php5-xdebug":
      ensure => present,
      require => Package["php5-cli"];
  }

  service { "php5-fpm":
    name => "php5-fpm",
    enable => true,
    ensure => running,
    hasrestart => true,
    require => Package["php5-fpm"],
  }

  exec { "php5-mongo":
    command => "/usr/bin/pecl install mongo",
    unless => '/usr/bin/test -n "`pecl list|grep mongo`"',
    require => [
        Package["make", "php5-dev", "php-pear"], 
        Anchor['mongodb::install::end']
    ];
  }

  file { "/etc/php5/cli/php.ini":
    ensure => present,
    content => template("php/etc/php5/cli/php.ini.erb"),
    require => Package["php5-cli"],
  }

  file { "/etc/php5/fpm/php.ini":
    ensure => present,
    content => template("php/etc/php5/fpm/php.ini.erb"),
    notify => Service["php5-fpm"],
    require => Package["php5-fpm"],
  }

  file { "/etc/php5/fpm/php-fpm.conf":
    ensure => present,
    content => template("php/etc/php5/fpm/php-fpm.conf.erb"),
    notify => Service["php5-fpm"],
    require => Package["php5-fpm"],
  }

  file { "/etc/php5/fpm/pool.d/www.conf":
    ensure => present,
    content => template("php/etc/php5/fpm/pool.d/www.conf.erb"),
    notify => Service["php5-fpm"],
    require => Package["php5-fpm"],
  }

  file { "/etc/php5/cli/conf.d":
    ensure => "link",
    target => "/etc/php5/conf.d",
    require => [Package["php5-fpm"], File["/etc/php5/conf.d"]],
  }

  file { "/etc/php5/conf.d/":
    ensure => "directory",
    require => Package["php5-fpm"],
  }

  file { "/etc/php5/mods-available/":
    ensure => "directory",
    require => Package["php5-fpm"],
  }

  exec { "empty_php_conf_dir":
    command => "/bin/rm -rf /etc/php5/conf.d/*",
    require => File["/etc/php5/conf.d/"],
  }

  file { "/etc/php5/fpm/conf.d":
    ensure => "link",
    target => "/etc/php5/conf.d",
    require => Package["php5-fpm"],
  }

  file { "/etc/php5/mods-available/xdebug.ini":
    ensure => present,
    content => template("php/etc/php5/mods-available/xdebug.ini.erb"),
    purge => true,
    require => Package["php5-xdebug"],
  }

  file { "/etc/php5/mods-available/curl.ini":
    ensure => present,
    content => template("php/etc/php5/mods-available/curl.ini.erb"),
    purge => true,
    require => Package["php5-curl"],
  }

  file { "/etc/php5/mods-available/pdo.ini":
    ensure => present,
    content => template("php/etc/php5/mods-available/pdo.ini.erb"),
    require => Package["php5-fpm"],
  }

  file { "/etc/php5/mods-available/mongo.ini":
    ensure => present,
    content => 'extension=mongo.so',
    require => Exec["php5-mongo", "empty_php_conf_dir"],
  }

  file { "/etc/php5/conf.d/40-mongo.ini":
    ensure => "link",
    target => "../mods-available/mongo.ini",
    require => File["/etc/php5/mods-available/mongo.ini"],
  }

  file { "/etc/php5/conf.d/30-xdebug.ini":
    ensure => "link",
    target => "../mods-available/xdebug.ini",
    require => [File["/etc/php5/mods-available/xdebug.ini"], Exec["empty_php_conf_dir"]],
  }

  file { "/etc/php5/conf.d/20-curl.ini":
    ensure => "link",
    target => "../mods-available/curl.ini",
    require => [File["/etc/php5/mods-available/curl.ini"], Exec["empty_php_conf_dir"]],
  }

}
