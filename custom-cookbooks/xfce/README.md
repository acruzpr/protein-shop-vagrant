Xfce
====

This cookbook installs Xfce, a stripped down GUI framework.

The usage here is as the shortest path to add a GUI to a server base virtual
machine image. This is helpful because most public Vagrant boxes are servers
lacking any installed GUI framework.

Attributes
----------

`node[:xfce][:apply_network_hack]` - boolean

For Virtualbox / Vagrant setup this can prevent VM network death due to changing
runlevel or other related issues. See
[Vagrant issue #391](https://github.com/mitchellh/vagrant/issues/391#issuecomment-14039313).

`node[:xfce][:target_is_server]` - boolean

If true, then assume that the machine is a server without any existing GUI and
make appropriate changes to ensure that Xfce starts up on provisioning and
is used by default going forward.
