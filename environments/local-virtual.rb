name 'local-virtual'
description 'Local virtual machine environment.'

default_attributes(
  :xfce => {
    :apply_network_hack => true,
    :target_is_server => true
  }
)
