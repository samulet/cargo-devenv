node default {

  # Настройки пакетов
  include php
  include nginx

  # Настройка системного окружения
  include setenv

  # Настройки сайта
  include site
}