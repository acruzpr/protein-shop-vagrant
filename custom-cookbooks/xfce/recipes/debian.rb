#
# Installation for Debian platforms.
#

# ---------------------------------------------------------------------
# Manage network hack to fix potential issue with VM.
# ---------------------------------------------------------------------

# Virtualbox VMs in a Vagrant environment can be very cranky when using GUI and
# runlevel changes. The network service may stop working, preventing Vagrant
# from connecting via ssh and managing shared folders.
#
#This is one of the fixes. See:
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
# Install Xfce.
# ---------------------------------------------------------------------

package 'xfce4'

# ---------------------------------------------------------------------
# Change runlevel for servers without an installed GUI.
# ---------------------------------------------------------------------

if node[:xfce][:target_is_server]

  # TODO: switch default runlevel, switch current runlevel

end
