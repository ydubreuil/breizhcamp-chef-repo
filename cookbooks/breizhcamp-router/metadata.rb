name             'breizhcamp-router'
maintainer       'BreizhCamp'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures breizhcamp-router'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'network_interfaces'
depends          'dhcp', '~> 2.2.2'
depends          'bind', '~> 1.1.2'
depends          'iptables-ng'

