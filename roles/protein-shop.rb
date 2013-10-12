name "protein-shop"
description "A machine for running ProteinShop."

# The install ordering here matters: the ProteinShop OpenGL stuff has to be in
# place before the XFCE GUI and support is installed.
run_list [
  'recipe[build-essential]',
  'recipe[protein-shop-requirements]',
  'recipe[xfce]'
]
