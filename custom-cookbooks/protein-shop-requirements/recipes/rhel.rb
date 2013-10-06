#
# Installation for RPM-based platforms.
#

# ---------------------------------------------------------------------
# CentOS 5/6 Necessities
# ---------------------------------------------------------------------

  # Why don't they just give in and add remi and epel repos to the base distro?
if node['platform'] == 'centos'
  include_recipe 'yum::epel'
  include_recipe 'yum::remi'
end

# ---------------------------------------------------------------------
# Fortran 77 compatibility.
# ---------------------------------------------------------------------

pkgs = %w{
  compat-gcc-34-g77
  compat-libf2c-34
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# ---------------------------------------------------------------------
# OpenGL + GLUT
# ---------------------------------------------------------------------

pkgs = %w{
  freeglut-devel
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# ---------------------------------------------------------------------
# Fast Light Toolkit
# ---------------------------------------------------------------------

pkgs = %w{
  fltk-devel
  fltk-fluid
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
