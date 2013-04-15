class php_modules::apc {
    include php

	php::module { "apc":
		module_prefix => "php-"
	}
}