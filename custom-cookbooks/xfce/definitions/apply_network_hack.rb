# Virtualbox VMs in a Vagrant environment can be very cranky when using GUI and
# runlevel changes. The network service may stop working, preventing Vagrant
# from connecting via ssh and managing shared folders.
#
# This is one of the fixes. See:
# https://github.com/mitchellh/vagrant/issues/391#issuecomment-14039313

define :apply_network_hack do
  # Turn off the Xfce network manager and get it out of the way, as it will
  # block restarts of the network.
  if node[:platform_family] == 'rhel'
    execute 'chkconfig NetworkManager off'
    execute '/etc/init.d/NetworkManager stop'
  end

  # Bounce the network on entering a runlevel.
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
