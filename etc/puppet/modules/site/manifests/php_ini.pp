define site::php_ini ( $target ) {

    include php

    php::augeas {
        "${name}-max_execution_time":
            entry  => 'PHP/max_execution_time',
            value  => '300',
            target => $target;
        "${name}-memory_limit":
            entry  => 'PHP/memory_limit',
            value  => '-1',
            target => $target;
        "${name}-disable_functions":
            entry  => 'PHP/disable_functions',
            ensure => absent,
            target => $target;
        "${name}-error_reporting":
            entry  => 'PHP/error_reporting',
            value  => 'E_ALL',
            target => $target;
        "${name}-display_errors":
            entry  => 'PHP/display_errors',
            value  => 'Off',
            target => $target;
        "${name}-log_errors":
            entry  => 'PHP/log_errors',
            value  => 'On',
            target => $target;
        "${name}-log_errors_max_len":
            entry  => 'PHP/log_errors_max_len',
            value  => '10240',
            target => $target;
        "${name}-error_log":
            entry  => 'PHP/error_log',
            value  => "$php_error_log",
            target => $target;
        "${name}-track_errors":
            entry  => 'PHP/track_errors',
            value  => 'On',
            target => $target;
        "${name}-html_errors":
            entry  => 'PHP/html_errors',
            value  => 'Off',
            target => $target;
        "${name}-date_timezone":
            entry  => 'Date/date.timezone',
            value  => 'Europe/Moscow',
            target => $target;
        "${name}-date_default_latitude":
            entry  => 'Date/date.default_latitude',
            value  => '55.614',
            target => $target;
        "${name}-date_default_longitude":
            entry  => 'Date/date.default_longitude',
            value  => '37.744324',
            target => $target;
        "${name}-mbstring-internal_encoding":
            entry  => 'mbstring/mbstring.internal_encoding',
            value  => 'UTF-8',
            target => $target;
        "${name}-mbstring-func_overload":
            entry  => 'mbstring/mbstring.func_overload',
            value  => '0',
            target => $target;
    }
}
