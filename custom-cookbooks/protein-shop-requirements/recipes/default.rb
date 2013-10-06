#
# Divert flow of execution to one of the platform-specific recipes.
#

begin
  include_recipe "protein-shop-requirements::#{node[:platform_family]}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Log.warn "A protein-shop recipe does not exist for the platform_family: #{node[:platform_family]}"
end
