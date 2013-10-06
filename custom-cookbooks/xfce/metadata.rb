name              'xfce'
maintainer        'Reason'
maintainer_email  'reason@exratione.com'
license           'MIT'
description       'Install Xfce.'
version           '0.0.1'
recipe            'xfce', 'Install Xfce.'

%w{ fedora redhat centos amazon scientific oracle ubuntu debian }.each do |os|
  supports os
end
