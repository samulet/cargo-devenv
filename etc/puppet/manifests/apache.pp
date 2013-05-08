class apache {

    package { "apache2":
        ensure => absent,
        before => Service['nginx'],
    }

    service { "apache2":
        ensure => stopped,
        enable => false,
        hasstatus => true,
        hasrestart => true,
        before => Package['apache2'],
    }

}