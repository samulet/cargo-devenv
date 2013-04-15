class webserver {
    include php
    include nginx

    include php_modules::xdebug
    include php_modules::curl

    include site

    package {"php5-fpm":
      ensure => present,
      require => Exec['php54_repository'];
    }

    service { "php5-fpm":
        name => "php5-fpm",
        enable => true,
        ensure => running,
        hasrestart => true,
        require => Package["php5-fpm"],
    }
}
