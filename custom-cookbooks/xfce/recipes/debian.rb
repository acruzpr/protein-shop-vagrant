#
# Installation for Debian platforms.
#

# ---------------------------------------------------------------------
# Install Xfce.
# ---------------------------------------------------------------------

package 'xfce4'

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

  else
    Chef::Log.warn "Failed to set runlevel to 5 - this platform doesn't use any of the recognized methods of doing so."
  end
end
