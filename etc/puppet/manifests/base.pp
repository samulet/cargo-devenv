$project_root = "/var/www/cargo"

# Set paths to use in exec commands
Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin' }

class { 'apt':
	always_apt_update => true
}

# Modules to include.
include repository
include dependencies

include webserver
include composer
include zmq
include phpunit

# Настройка системного окружения
include setenv

include stdlib

include mongo