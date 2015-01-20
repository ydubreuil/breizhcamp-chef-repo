name             'labs-docker'
maintainer       'BreizhCamp'
maintainer_email 'nospam@breizhcamp.org'
license          'Apache 2.0'
description      'Installs/Configures labs-docker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'docker', '= 0.36.0'
depends          'apache2'
depends          'iptables-ng'

supports         'ubuntu', "= 14.04"

