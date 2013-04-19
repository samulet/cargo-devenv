include php

# composer installation to be run after php modules.
class { 'composer':
    command_name => 'composer',
    target_dir   => '/usr/local/bin',
    auto_update  => true,
    require      => Class['php_modules']
}

## Install composer dependencies only if a composer.json file is present.
exec { 'composer install --dev':
    cwd     => "$project_root",
    require => Class['composer'],
    onlyif  => "test -f ${project_root}/composer.json"
}
