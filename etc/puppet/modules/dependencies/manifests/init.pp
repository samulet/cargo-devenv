# Installs dependencies needed by various PHP modules.
class dependencies {
    package {'git-core':
        name   => 'git-core',
        ensure => installed,
        require => Class['apt::update'],
    }
    package {'pkg-config':
        name   => 'pkg-config',
        ensure => installed,
        require => Class['apt::update'],
    }
    package {'build-essential':
        name   => 'build-essential',
        ensure => installed,
        require => Class['apt::update'],
    }
    package {"vim":
        ensure => installed,
        require => Class['apt::update'],
    }
    package { "htop":
        ensure => installed,
        require => Class['apt::update'],
    }
    package { "augeas-tools":
        ensure => installed,
        require => Class['apt::update'],
    }
    package { "libaugeas-dev":
        ensure => installed,
        require => Class['apt::update'],
    }
    package { "libaugeas-ruby":
        ensure => installed,
        require => Class['apt::update'],
    }
}
