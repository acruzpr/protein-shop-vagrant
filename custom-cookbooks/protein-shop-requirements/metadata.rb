name              'protein-shop-requirements'
maintainer        'Reason'
maintainer_email  'reason@exratione.com'
license           'MIT'
description       'Install additional necessities for compiling and running ProteinShop.'
version           '0.0.1'
recipe            'protein-shop-requirements', 'Install dependencies.'

depends 'build-essential'
depends 'apt'
depends 'yum'

%w{ fedora redhat centos amazon scientific oracle ubuntu debian }.each do |os|
  supports os
end
