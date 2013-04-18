define site::fpm ( $target ) {

    include php

    php::augeas {
        "${name}-error_log":
            notify => Service['php5-fpm'],
            entry  => 'global/error_log',
            value  => "${log_dir}/php5-fpm.log",
            target => $target;
        "${name}-pid":
            notify => Service['php5-fpm'],
            entry  => 'global/pid',
            value  => '/var/run/php5-fpm.pid',
            target => $target;
    }
}
