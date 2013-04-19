class php_modules::xdebug {

    php::pecl::module { "xdebug":
        service => 'php5-fpm',
        require => [
            Exec['pear-config-set-auto_discover'],
            Package['php', 'php5-fpm', 'php5-dev'],
        ],
        use_package => "no",
        before => [
            Php::Augeas["xdebug-extension"],
            Php::Augeas["xdebug-remote_enable"],
            Php::Augeas["xdebug-remote_host"],
            Php::Augeas["xdebug-remote_port"],
            Php::Augeas["xdebug-idekey"],
            Php::Augeas["xdebug-cli_color"],
            Php::Augeas["xdebug-var_display_max_depth"],
            Php::Augeas["xdebug-html_errors"],
        ],
    }

    $target = "$php::config_dir/mods-available/xdebug.ini"

    file {"$php::config_dir/conf.d/xdebug.ini":
        ensure => link,
        target => $target,
        require => [
            Php::Pecl::Module['xdebug'],
        ],
        notify => Service['php5-fpm'],
    }

    php::augeas {
        'xdebug-extension':
            entry  => '.anon/extension',
            value  => 'xdebug.so',
            target => $target,
            before => Php::Augeas[
                'xdebug-remote_enable'
            ];
        'xdebug-remote_enable':
            entry  => '.anon/xdebug.remote_enable',
            value  => 'true',
            target => $target,
            before => Php::Augeas[
                'xdebug-remote_host'
            ];
        'xdebug-remote_host':
            entry  => '.anon/xdebug.remote_host',
            value  => '10.0.2.2',
            target => $target,
            before => Php::Augeas[
                'xdebug-remote_port'
            ];
        'xdebug-remote_port':
            entry  => '.anon/xdebug.remote_port',
            value  => '9000',
            target => $target,
            before => Php::Augeas[
                'xdebug-idekey'
            ];
        'xdebug-idekey':
            entry  => '.anon/xdebug.idekey',
            value  => 'PHPSTORM',
            target => $target,
            before => Php::Augeas[
                'xdebug-cli_color'
            ];
        'xdebug-cli_color':
            entry  => '.anon/xdebug.cli_color',
            value  => '1',
            target => $target,
            before => Php::Augeas[
                'xdebug-var_display_max_depth'
            ];
        'xdebug-var_display_max_depth':
            entry  => '.anon/xdebug.var_display_max_depth',
            value  => '10',
            target => $target,
            before => Php::Augeas[
                'xdebug-html_errors'
            ];
        'xdebug-html_errors':
            entry  => '.anon/xdebug.html_errors',
            value  => '1',
            target => $target;
    }
}