#
# Installation for Debian platforms.
#

# ---------------------------------------------------------------------
# Fortran 77 compatibility.
# ---------------------------------------------------------------------

# This provides the Fortran 77 compiler f77, where the original ProteinShop
# makefile used g77.
#pkgs = %w{
#  fort77
#}
# This provides the modern Fortran compiler gfortran.
pkgs = %w{
  gfortran
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# ---------------------------------------------------------------------
# OpenGL + GLUT
# ---------------------------------------------------------------------

# We need to add this repo to get access to amd64 libglapi-mesa on Ubuntu
# precise, possibly others.
apt_repository 'xorg-edgers' do
  uri 'http://ppa.launchpad.net/xorg-edgers/ppa/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key '8844C542'
  deb_src true
end

# The binutils-gold package solves linker issues with OpenGL. Freeglut is the
# high-level package to install all the needed OpenGl stuff.
pkgs = %w{
  binutils-gold
  freeglut3
  freeglut3-dev
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# ---------------------------------------------------------------------
# Fast Light Toolkit
# ---------------------------------------------------------------------

# TODO: do I need these?
# libfltk-gl1.3 - Fast Light Toolkit - OpenGL rendering support
# libfltk-images1.3 - Fast Light Toolkit - image loading support
pkgs = %w{
  libfltk1.3-dev
  fluid
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
