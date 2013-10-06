#
# Divert flow of execution to one of the platform-specific recipes.
#

begin
  include_recipe "xfce::#{node[:platform_family]}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Log.warn "An xfce recipe does not exist for the platform_family: #{node[:platform_family]}"
end
