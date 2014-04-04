name             'lampapp'
maintainer       'rj45_test'
maintainer_email 'max@mkoryakin.com'
license          'All rights reserved'
description      'Installs/Configures LAMP'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2"
depends "mysql"
depends "php"
