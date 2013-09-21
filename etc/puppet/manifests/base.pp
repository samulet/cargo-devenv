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

node default {
	include "dependencies"

	include "webserver"
	include "composer"
	include "phpunit"

	include "setenv"

	include "stdlib"

	include "mongo"
}

class mongo {
    include mongodb
    include php_modules::mongo

    # Это нужно только для обхода ошибки старта сервиса mongodb при отсутствии init-скрипта
    exec {"mongodb-init":
        command => "touch /etc/init.d/mongodb && chmod 755 /etc/init.d/mongodb",
        before => Service["${::mongodb::params::old_servicename}"],
    }

    mongodb::mongod {
        "mdb01":
            mongod_instance => "mdb01"
    }

}