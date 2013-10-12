#
# Installation for RPM-based platforms.
#
# TODO: The CentOS VM specified in the Vagrant script already has GDM installed.
#
# So installing GDM is probably going to be necessary for general targets.
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
# Manage network hack to fix potential issue with VM.
# ---------------------------------------------------------------------

if node[:xfce][:apply_network_hack]
  apply_network_hack
end

# ---------------------------------------------------------------------
# Change runlevel for servers without an installed GUI.
# ---------------------------------------------------------------------

if node[:xfce][:target_is_server]
  # TODO: all RHEL platform distros use /etc/inittab to define default runlevel?
  inittab_runlevel 5
  # Actually change runlevel now.
  execute '/sbin/telinit 5'
end
