class nginx::sites {
  define site ( $ensure = 'present', $content = '' ) {
    case $ensure {
      'present' : {
        exec { "/bin/ln -s /etc/nginx/sites-available/$name /etc/nginx/sites-enabled/$name":
          unless => "/bin/sh -c '[ -L /etc/nginx/sites-enabled/$name ] \\
            && [ /etc/nginx/sites-enabled/$name -ef /etc/nginx/sites-available/$name ]'",
          notify => Service["nginx"],
          require => File["/etc/nginx/sites-available/$name"],
        }
      }
      'absent' : {
        exec { "/bin/rm /etc/nginx/sites-enabled/$name":
          onlyif => "/usr/bin/test -h /etc/nginx/sites-enabled/$name",
          notify => Service["nginx"],
        }
      }
      default: { err ( "Unknown ensure value: '$ensure'" ) }
    }
  }

  nginx::sites::site { "default" : ensure => absent }
}