define site::fpm ( $target ) {

    include php

    php::augeas {
        "${name}-error_log":
            entry  => 'global/error_log',
            value  => "${log_dir}/php5-fpm.log",
            target => $target;
        "${name}-pid":
            entry  => 'global/pid',
            value  => '/var/run/php5-fpm.pid',
            target => $target;
    }
}
