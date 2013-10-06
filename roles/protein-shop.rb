name "protein-shop"
description "A machine for running ProteinShop."

run_list [
  'recipe[build-essential]',
  'recipe[protein-shop-requirements]',
  'recipe[xfce]'
]
