#
# Installation for Debian platforms.
#

# Ensure an apt-get update runs, as that is needed for the xfce install.
include_recipe 'apt'

# ---------------------------------------------------------------------
# Install Xfce.
# ---------------------------------------------------------------------

Chef::Log.info "Note that installing xfce4 will probably take some time..."

package 'xfce4'
# We need a DM package o show the login screen if this is a plain server.
if node[:xfce][:target_is_server]
  package 'lxdm'
end

# ---------------------------------------------------------------------
# Manage network hack to fix potential issue with Vagrant and the VM.
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
    Chef::Log.warn "Failed to set default runlevel to 5 - this platform doesn't use any of the recognized methods of doing so."
  end
end


# ---------------------------------------------------------------------
# Launch DM for servers without an installed GUI.
# ---------------------------------------------------------------------

# This will fire up the GUI login screen.
if node[:xfce][:target_is_server]
  execute 'lxdm -d'
  # Actually change runlevel now.
  execute '/sbin/telinit 5'
end
