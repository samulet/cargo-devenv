class php_modules::mongo {

    php::pecl::module { "mongo":
        service => 'php5-fpm',
        require => [
            Exec['pear-config-set-auto_discover'],
            Package['php', 'php5-fpm', 'php5-dev'],
            Anchor['mongodb::install::end'],
        ],
        use_package => "no",
        before => [
            Php::Augeas["mongo-extension"],
        ],
    }

    $target = "$php::config_dir/mods-available/mongo.ini"

    file {"$php::config_dir/conf.d/mongo.ini":
        ensure => link,
        target => $target,
        require => [
            Php::Pecl::Module['mongo'],
        ],
        notify => Service['php5-fpm'],
    }

    php::augeas {
        'mongo-extension':
            entry  => '.anon/extension',
            value  => 'mongo.so',
            target => $target;
    }
}