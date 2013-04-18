class site::cargo {
    file { "/etc/nginx/sites-available/cargo":
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 644,
        content  => template("site/nginx/sites-available/cargo.erb"),
        require => Package["nginx"],
    }

    nginx::sites::site { "cargo" : ensure => present }

    $target = "${php::config_dir}/fpm/pool.d/www.conf"

    php::augeas {
        "fpm-site-listen":
            notify => Service['php5-fpm'],
            entry  => 'www/listen',
            value  => "${fpm_socket}",
            target => $target;
        "fpm-site-catch_workers_output":
            notify => Service['php5-fpm'],
            entry  => 'www/catch_workers_output',
            value  => 'yes',
            target => $target;
    }
}