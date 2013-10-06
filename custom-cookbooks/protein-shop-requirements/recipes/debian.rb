#
# Installation for Debian platforms.
#

# ---------------------------------------------------------------------
# Fortran 77 compatibility.
# ---------------------------------------------------------------------

# TODO what else?
pkgs = %w{
  f2c
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
}

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
