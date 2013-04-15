class zmq {
    include php
    include php::pear
    include php::devel

	php::pecl::module { 'pear.zero.mq/zmq-beta':
		use_package     => "no",
		preferred_state => "beta",
		require         => [Exec['pear-config-set-auto_discover'],Package['libzmq-dev']],
	    service => 'php5-fpm',
	}

	file {'/etc/php5/conf.d/zmq.ini':
		path    => '/etc/php5/conf.d/zmq.ini',
		content => 'extension=zmq.so',
		require => Exec['pecl-pear.zero.mq/zmq-beta'],
		notify  => Service['php5-fpm'],
	}

	package {'libzmq-dev':
		name   => 'libzmq-dev',
		ensure => installed,
		require => Class['apt::update'],
	}

}