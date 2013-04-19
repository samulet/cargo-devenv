$project_root = "/var/www/cargo"
$document_root = "${project_root}/public"
$log_dir = "/vagrant/dev/logs"
$php_error_log = "${log_dir}/php_errors.log"
$fpm_socket = '/var/run/php5-fpm.sock'

# Set paths to use in exec commands
Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin' }

class { 'apt':
    always_apt_update => true
}

include dependencies

include webserver
include composer
include phpunit

# Настройка системного окружения
include setenv

include stdlib

include mongo