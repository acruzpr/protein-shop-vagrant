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

attribute 'xfce/apply_network_hack',
  :display_name => 'Apply network hack?',
  :description => 'Whether or not to employ a hack to avoid a Vagrant/Virtualbox issue that kills networking on the VM.',
  :required => 'optional'

attribute 'xfce/target_is_server',
  :display_name => 'Target machine is server?',
  :description => 'Whether or not the target machine is a server with no existing GUI framework. If so make some additional changes.',
  :required => 'optional'
