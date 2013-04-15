class php_modules::xdebug {
	php::pecl::module { "xdebug":
        service => 'php5-fpm',
		require => [Exec['pear-config-set-auto_discover'],Exec['php54_repository']],
	}
}