Пакет конфигурации puppet для разворачивания окружения для разработки проекта  cargo.

## Описание окружения

## Схема расположения проекта

В пакет включены три файла конфигурации вагранта. Выбор одного из файлов зависит от расположения каталога с этим проетом относительно каталога с проектом MashaiMedvedi/cargo:

* Vagrantfile.dist - предполагает запуск вагранта из каталога этого проекта
* Vagrantfile.parentdir - предполагает расположение каталогов этого проекта и проекта cargo в одном общем каталоге и запуск вагранта из общего родительского каталога
* Vagrantfile.subdir - предполагает расположение каталога этого проекта внутри каталога с проектом cargo

