group { 'puppet': ensure => present }
Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }
File { owner => 0, group => 0, mode => 0644 }

class {'apt':
  always_apt_update => true,
}

Class['::apt::update'] -> Package <|
    title != 'python-software-properties'
and title != 'software-properties-common'
|>

    apt::key { '4F4EA0AAE5267A6C': }

apt::ppa { 'ppa:ondrej/php5-oldstable':
  require => Apt::Key['4F4EA0AAE5267A6C']
}

class { 'puphpet::dotfiles': }

package { [
    'build-essential',
    'vim',
    'curl',
    'git-core',
    'redis-server',
    'memcached',
    'mongodb',
    'nodejs',
    'nodejs-dev',
    'npm',
    'imagemagick',
    'nano',
    'wkhtmltopdf'
  ]:
  ensure  => 'installed',
}

class { 'apache': }

apache::dotconf { 'custom':
  content => 'EnableSendfile Off',
}

apache::module { 'rewrite': }

apache::vhost { 'symbox.dev':
  server_name   => 'symbox.dev',
  serveraliases => [
    '*'
  ],
  docroot       => '/var/www/web',
  port          => '80',
  env_variables => [
],
  priority      => '2',
}

class { 'php':
  service             => 'apache',
  service_autorestart => false,
  module_prefix       => '',
}

php::module { 'php5-mysql': }
php::module { 'php5-cli': }
php::module { 'php5-common': }
php::module { 'php5-curl': }
php::module { 'php5-gd': }
php::module { 'php5-imagick': }
php::module { 'php5-imap': }
php::module { 'php5-intl': }
php::module { 'php5-ldap': }
php::module { 'php5-mcrypt': }
php::module { 'php5-memcached': }
php::module { 'php5-sqlite': }
php::module { 'php-apc': }

class { 'php::devel':
  require => Class['php'],
}

class { 'php::pear':
  require => Class['php'],
}


php::pecl::module { 'mongo':
  use_package => false,
}
php::pecl::module { 'redis':
  use_package => false,
}
php::pecl::module { 'intl':
  use_package => false,
}

class { 'xdebug':
  service => 'apache',
}

class { 'composer':
  require => Package['php5', 'curl'],
}

puphpet::ini { 'xdebug':
  value   => [
    'xdebug.default_enable = 1',
    'xdebug.remote_autostart = 0',
    'xdebug.remote_connect_back = 1',
    'xdebug.remote_enable = 1',
    'xdebug.remote_handler = "dbgp"',
    'xdebug.remote_port = 9000',
    'xdebug.max_nesting_level = 500',
    'xdebug.auto_trace = 0',
    'xdebug.idekey = symbox'
  ],
  ini     => '/etc/php5/conf.d/zzz_xdebug.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

puphpet::ini { 'php':
  value   => [
    'date.timezone = "Europe/Berlin"'
  ],
  ini     => '/etc/php5/conf.d/zzz_php.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

puphpet::ini { 'custom':
  value   => [
    'short_open_tag = Off',
    'display_errors = On',
    'error_reporting = -1',
    'allow_url_fopen = 1'
  ],
  ini     => '/etc/php5/conf.d/zzz_custom.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

# crosslink the php.ini files, remove this statement if you don't want this
file { '/etc/php5/apache2/php.ini':
  ensure => 'link',
  target => '/etc/php5/cli/php.ini',
  notify  => Service['apache'],
  require => [
    Package['php5', 'php5-cli', 'apache']
  ],
}

class { 'mysql::server':
  config_hash   => { 'root_password' => 'symbox' }
}

mysql::db { 'symbox':
  grant    => [
    'ALL'
  ],
  user     => 'symbox',
  password => 'symbox',
  host     => 'localhost',
  charset  => 'utf8',
  require  => Class['mysql::server'],
}

class { 'phpmyadmin':
  require => [Class['mysql::server'], Class['mysql::config'], Class['php']],
}

apache::vhost { 'phpmyadmin.symbox.dev':
  server_name => 'phpmyadmin.symbox.dev',
  docroot     => '/usr/share/phpmyadmin',
  port        => 80,
  priority    => '1',
  require     => Class['phpmyadmin'],
}

