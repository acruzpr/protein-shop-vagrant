#
# Installation for Debian platforms.
#

# Ensure an apt-get update runs.
include_recipe 'apt'

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

pkgs = %w{
  libfltk1.3-dev
  fluid
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
