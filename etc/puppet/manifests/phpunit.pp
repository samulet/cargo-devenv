class phpunit {
    include php
    include php::pear

    php::pear::module { "PHPUnit":
        use_package => false,
        alldeps     => true,
        service     => 'php5-fpm',
        preferred_state => "beta",
        repository  => "pear.phpunit.de",
        require     => [
            Package['php'],
        ],
    }
}