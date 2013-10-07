#
# Change default runlevel by editing /etc/inittab.
#

# Change /etc/inittab default runlevel from 3 to 5.
define :inittab_runlevel, :runlevel => 5 do
  if !params[:runlevel]
    params[:runlevel] = params[:name]
  end
  execute "sed -i \"s/id:.:initdefault:/id:#{params[:runlevel]}:initdefault:/g\" /etc/inittab"
end
