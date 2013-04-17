$project_root = "/var/www/cargo"
$php_error_log = "/vagrant/dev/logs/php_errors.log"

# Set paths to use in exec commands
Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin' }

class { 'apt':
    always_apt_update => true
}

include dependencies

include webserver
include composer
include zmq
include phpunit

# Настройка системного окружения
include setenv

include stdlib

include mongo