#
# Installation for RPM-based platforms.
#

# ---------------------------------------------------------------------
# CentOS 5/6 Necessities
# ---------------------------------------------------------------------

if node['platform'] == 'centos'
  # Why don't they just give in and add remi and epel repos to the distro?
  include_recipe 'yum::epel'
  include_recipe 'yum::remi'
end

# ---------------------------------------------------------------------
# Install
# ---------------------------------------------------------------------

# Can't do this groupinstall through the package resource.
execute 'yum --assumeyes install @xfce'

# Necessary font packages.
pkgs = %w{
  xorg-x11-fonts-Type1
  xorg-x11-fonts-misc
}
pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# ---------------------------------------------------------------------
# Change runlevel
# ---------------------------------------------------------------------

# The server will have a default runlevel of 3, but we want it to be 5.

# TODO: this isn't going to work for every RHEL setup. Some are not going to
# use /etc/inittab.

# Change /etc/inittab default runlevel from 3 to 5.
execute 'sed -i s/3/5/g /etc/inittab'

# Actually change runlevel now.
#
# Note that if you are using Virtualbox and Vagrant you may find that you lose
# networking in the VM when doing this unless you have the following in your
# Vagrantfile:
#
# config.vm.provider :virtualbox do |vb|
#   vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
# end
#
# Onwards:
execute '/sbin/telinit 5'
