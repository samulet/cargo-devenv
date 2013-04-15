class mongo {
    include mongodb

    mongodb::mongod {
        "mdb01":
            mongod_instance => "mdb01"
    }
}