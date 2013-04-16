class mongo {
    include mongodb

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