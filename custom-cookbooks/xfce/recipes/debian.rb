#
# Installation for Debian platforms.
#

# ---------------------------------------------------------------------
# Install Xfce.
# ---------------------------------------------------------------------


Chef::Log.info "Installing lightdm and xfce4 will probably take some time..."

# The lightdm package provides the login screen and should come first.
pkgs = %w{
  lightdm
  xfce4
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
  # Change runlevel.
  if File.exist?('/etc/inittab')
    # Debian, probably.
    inittab_runlevel 5
  elsif File.exist?('/etc/init/rc-sysinit.conf')
    # Ubuntu, probably.
    upstart_runlevel 5
  else
    Chef::Log.warn "Failed to set runlevel to 5 - this platform doesn't use any of the recognized methods of doing so."
  end


end
