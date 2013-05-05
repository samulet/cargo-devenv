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

    file { "/etc/php5/fpm/pool.d/www.conf":
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 644,
        content  => template("site/php5/fpm/pool.d/www.erb"),
        require => Package["php5-fpm"],
        notify => Service["php5-fpm"]
    }

}