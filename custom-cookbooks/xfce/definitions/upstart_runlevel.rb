#
# Change default runlevel by editing /etc/init/rc-sysinit.conf
#
# This is the case where default runlevel is managed via Upstart, as in
# Ubuntu.
#
# (We could still override that by creating an /etc/inittab file, but are going
# with editing /etc/init/rc-sysinit.conf here).

define :upstart_runlevel, :runlevel => 5 do
  if !params[:runlevel]
    params[:runlevel] = params[:name]
  end
  execute "sed -i \"s/DEFAULT_RUNLEVEL=./DEFAULT_RUNLEVEL=#{params[:runlevel]}/g\" /etc/init/rc-sysinit.conf"
end
