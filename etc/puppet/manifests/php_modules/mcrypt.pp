class php_modules::mcrypt {
    include php
    include repository

	php::module { "mcrypt":
	    service => "",
	    service_autorestart => false,
	    require => Exec['php54_repository'],
	}
}