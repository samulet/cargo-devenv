Пакет конфигурации puppet для разворачивания окружения для разработки проекта  cargo.

## Описание окружения

### Устанавливаемое ПО

* php 5.5 (cli, fpm)
  * xdebug
  * curl
  * mongo
* mongodb 2.4
* nginx
* composer
* git-core

### Настройки

* nginx-сайт cargo.dev
* php5-fpm + php5-fpm-worker
* php.ini для cli & fpm

### Установка

Простейшим вариантом для создания окружения является использование виртуальной машины. Чтобы ей воспользоваться
понадобятся:

1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrant](http://downloads.vagrantup.com/)

После установки VirtualBox и Vagrant:

1. Создаем каталог для разработки проекта. Он будет содержать все репозитории проекта

    ```
    mkdir cargo
    cd cargo
    ```

2. Клонируем репозитории

    ```
    git clone git@github.com:MashaiMedvedi/cargo.git site
    git clone git@github.com:MashaiMedvedi/cargo-api.git api
    git clone git@github.com:MashaiMedvedi/cargo-devenv.git devenv
    ```

    (На windows-машинах перед клонированием выполнить: git config --global core.autocrlf false
     и в настройках среды установить использование юниксовских переносов строки)

3. Устанавливаем конфигурацию вагранта

    ```
    cp devenv/Vagrantfile.dist ./Vagrantfile
    ```

4. Запускаем виртуальную машину

    ```
    vagrant up
    vagrant reload --provision
    ```

5. Переходим в каталог с клонированным проектом и устанавливаем пакеты

    ```
    vagrant ssh

    cd /var/www/cargo
    php composer.phar --dev install

    cd /var/www/api
    php composer.phar --dev install

    exit
    ```

    (если php composer.phar --dev install падает по таймауту, можно попробовать выполнить команду вот так:
     php composer.phar install --prefer-dist --no-dev)

6. Настраиваем хост-систему

    Необходимо настроить доступ к сайту в виртуальной машине из хост-системы. Для этого надо добавить маппинг имени в IP и проксирование запросов.

    В `/etc/hosts` добавляем

    ```
    127.0.0.1	cargo.dev
    ```

На этом установка заканчивается. Можно проверить доступность сайта зайдя браузером по адресу http://cargo.dev:8000
