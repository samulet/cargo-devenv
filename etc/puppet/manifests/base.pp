node default {

  # Настройки пакетов
  include php
  include nginx

  # Настройка системного окружения
  include setenv

  # Настройки сайта
  include site

  class { 'apt': }

  include stdlib

  include mongodb
  mongodb::mongod {
    "mdb01":
      mongod_instance => "mdb01"
  }

}