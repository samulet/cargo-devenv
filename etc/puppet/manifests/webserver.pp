class webserver {
    include php
    include nginx

    include php_modules::xdebug
    include php_modules::curl

    include site

    package {"php5-fpm":
      ensure => present,
      require => [
            Apt::Ppa['ppa:ondrej/php5'],
      ];
    }

    exec { "/usr/bin/aptitude -y install php5-dev":
      logoutput => 'on_failure',
      require => [
            Apt::Ppa['ppa:ondrej/php5'],
      ],
      before => [
            Php::Pecl::Module['pear.zero.mq/zmq-beta'],
            Php::Pecl::Module['xdebug'],
            Package['php5', 'php5-fpm', 'php-pear', 'php5-dev'],
      ];
    }
    
    apt::ppa {'ppa:ondrej/php5':
        before => [
            Package['php5', 'php5-fpm', 'php-pear', 'php5-dev'],
        ]
    }

    service { "php5-fpm":
        name => "php5-fpm",
        enable => true,
        ensure => running,
        hasrestart => true,
        require => Package["php5-fpm"],
    }

    site::php_ini { "php-cli":
        target => "${php::config_dir}/cli/php.ini",
        require => Package["php5"],
    }
    site::php_ini { "php-fpm":
        target => "${php::config_dir}/fpm/php.ini",
        require => Package["php5-fpm"],
    }
}
