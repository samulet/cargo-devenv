class php_modules::xdebug {

    php::pecl::module { "xdebug":
        service => 'php5-fpm',
        require => [
            Exec['pear-config-set-auto_discover'],
            Package['php'],
        ],
        use_package => "no",
        before => [
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

    php::augeas {
        'xdebug-remote_enable':
            entry  => '.anon/xdebug.remote_enable',
            value  => 'true',
            target => $target;
        'xdebug-remote_host':
            entry  => '.anon/xdebug.remote_host',
            value  => '10.0.2.2',
            target => $target;
        'xdebug-remote_port':
            entry  => '.anon/xdebug.remote_port',
            value  => '9000',
            target => $target;
        'xdebug-idekey':
            entry  => '.anon/xdebug.idekey',
            value  => 'PHPSTORM',
            target => $target;
        'xdebug-cli_color':
            entry  => '.anon/xdebug.cli_color',
            value  => '1',
            target => $target;
        'xdebug-var_display_max_depth':
            entry  => '.anon/xdebug.var_display_max_depth',
            value  => '10',
            target => $target;
        'xdebug-html_errors':
            entry  => '.anon/xdebug.html_errors',
            value  => '1',
            target => $target;
    }
}