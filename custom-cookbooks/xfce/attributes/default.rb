
# For Virtualbox / Vagrant setup to prevent VM network death due to
# changing runlevel.
#
# See:
# https://github.com/mitchellh/vagrant/issues/391#issuecomment-14039313
default[:xfce][:apply_network_hack] = false

# If true, then assume that the machine is a server without any existing GUI
# and make appropriate changes to see Xfce used by default.
default[:xfce][:target_is_server] = false
