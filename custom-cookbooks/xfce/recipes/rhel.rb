#
# Installation for RPM-based platforms.
#

# ---------------------------------------------------------------------
# Manage network hack to fix potential issue with VM.
# ---------------------------------------------------------------------

# Virtualbox VMs in a Vagrant environment can be very cranky when using GUI and
# runlevel changes. The network service may stop working, preventing Vagrant
# from connecting via ssh and managing shared folders.
#
# This is one of the fixes. See:
# https://github.com/mitchellh/vagrant/issues/391#issuecomment-14039313
if node[:xfce][:apply_network_hack]
  if !File.readlines('/etc/rc.local').grep(/ifdown eth0/).any?
    # Edit /etc/rc.local.
    # Remove any existing exit 0 line.
    execute 'sed -i "s/exit 0//g" /etc/rc.local'
    # Append:
    #ifdown eth0
    #sleep 1
    #ifup eth0
    #exit 0
    execute 'printf "ifdown eth0\nsleep 1\nifup eth0\nexit 0" >> /etc/rc.local'
  end
end

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
# Change runlevel for servers without an installed GUI.
# ---------------------------------------------------------------------

if node[:xfce][:target_is_server]
  # The server will have a default runlevel of 3, but we want it to be 5.
  # The effect of changing run level this way is to start up Xfce right now
  # and to have it start on future boots.

  # TODO: this isn't going to work for every RHEL setup. Some are not going to
  # use /etc/inittab.

  # Change /etc/inittab default runlevel from 3 to 5.
  execute 'sed -i s/3/5/g /etc/inittab'

  # Actually change runlevel now.
  execute '/sbin/telinit 5'
end
