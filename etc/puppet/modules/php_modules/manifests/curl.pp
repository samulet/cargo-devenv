class php_modules::curl {

    php::module { "curl":
        require => Package['curl'],
        service => 'php5-fpm',
    }

    package {"curl":
        ensure => installed,
        require => Class['apt::update'],
    }
}