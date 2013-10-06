ProteinShop With Vagrant
========================

[ProteinShop](http://proteinshop.org/) is a visualization tool for molecular
structure. It is no longer maintained, but the source is made available under
a GPL license.

This project offers an easy way to run ProteinShop on a local virtual machine
for the purposes of evaluation, curiosity, and so forth.

  * Vagrant is a tool for managing Virtualbox virtual machines.
  * Virtualbox runs virtual machines.
  * Chef is a provisioning tool for setting software on a machine.
  * Librarian-chef is a package manager for Chef cookbooks.

Two virtual machines can be configured, Ubuntu 12.04 and CentOS 6.4. Both are
64-bit, machines, so you will need a 64-bit host machine to make use of this
project.

This is a Fork of the ProteinShop Code
--------------------------------------

Changes have been made to the ProteinShop Makefile.

  * Switch to using gfortran rather than g77.

Setup in Brief
--------------

  * Install the latest versions of Vagrant, Virtualbox, and Chef, and Librarian-chef
  * Checkout this project.
  * On the command line in this project directory:

    librarian-chef install
    vagrant plugin install vagrant-vbguest
    vagrant up centos-6.4-x86_64

A base virtual machine image will download the first time you do this, then
launch, then run a setup and provisioning process. The download and provisioning
only has to be done once (unless you destroy the VM and start over, and even
then Vagrant keeps a copy of the original downloaded base box).

You can see the options for the machine name by running:

    vagrant status

The project has these Vagrant boxes configured:

  * centos-6.4-x86_64 - CentOS 6.4 64-bit
  * ubuntu-precise-x86_64 - Ubuntu 12.04 64-bit

Note that if you run "vagrant up" without any arguments then both boxes will
launch, which is probably not what you want.

What Happens if Vagrant Setup Fails?
------------------------------------

Using Vagrant to manage a VM that has a GUI is less reliable than running VMs
headless. You will see the occasional failures wherein Vagrant fails to
establish a connection to the server, or fails to detect when the boot process
completes.

Similar, the provisioning process requires downloading software from the
internet, and that also sometimes fails.

If either of these things happens, then you will see red error messages from
Vagrant. The best thing to do at that point is to shut down the VM and
retry, rerunning the provisioning if it hasn't yet completed:

    vagrant halt -f centos-6.4-x86_64
    vagrant up --provision centos-6.4-x86_64

Building ProteinShop
--------------------

After you are set up, you will find this project directory shared with the
VM under /vagrant. So the ProteinShop installation will be under:

    /vagrant/protein-shop

To build the ProteinShop source, log in to the VM as the vagrant user. Then on
the command line:

    cd /vagrant/protein-shop/src
    make clean
    make

This is a mix of C and Fortran 77 code. The original Fortran compiler used was
g77, but getting this installed on modern *NIX machines is a real pain, so it
has been replaced by gfortran.

Using ProteinShop
-----------------

To get ProteinShop running with sample protein data:

    cd  /vagrant/protein-shop/bin
    wget http://www.rcsb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=1ubq
    ./ProteinShop 1UBQ.pdb

General Pointers for Installing Vagrant, Virtualbox, and Chef
-------------------------------------------------------------

You will need later versions than are probably available in the package
respositories for your OS as of late 2013. Go to the source to get the latest
stable builds and installers:

  * [Vagrant downloads](http://downloads.vagrantup.com/)
  * [Virtualbox downloads](https://www.virtualbox.org/wiki/Downloads)
  * [Chef Client downloads](http://www.opscode.com/chef/install/)

Instructions for Installing Vagrant, Virtualbox, and Chef on Ubuntu 13.04
-------------------------------------------------------------------------

1) Run the following to obtain those packages that are usefully recent.

    sudo apt-get install chef ruby1.9.1-dev
    sudo gem install librarian-chef

2) Download the [latest Vagrant .deb package file](http://downloads.vagrantup.com/).
Don't use the older Vagrant version in the Ubuntu repositories.

3) Instructions for installing Virtualbox can be found
[at the Virtualbox site](https://www.virtualbox.org/wiki/Downloads). For
example, for to install a suitably recent version of Virtualbox, add this line
to /etc/apt/sources.list:

    deb http://download.virtualbox.org/virtualbox/debian raring contrib

Then run:

    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install virtualbox-4.2
