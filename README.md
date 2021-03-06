ProteinShop With Vagrant
========================

[ProteinShop](http://proteinshop.org/) is a visualization tool for molecular
structure. It is no longer maintained, but the source is made available under
a GPL license.

This project offers an easy way to run ProteinShop on a local virtual machine
for the purposes of evaluation, curiosity, and so forth. The tools used are
Vagrant, Virtualbox, Chef, and Librarian-chef.

  * Vagrant is a tool for managing Virtualbox virtual machines.
  * Virtualbox runs virtual machines.
  * Chef is a provisioning tool for setting software on a machine.
  * Librarian-chef is a package manager for Chef cookbooks.

The virtual machine that can be set up here is a CentOS 6.4 64 bit OS.

Tasks Yet to Be Accomplished
----------------------------

  * Setting up an alternative Ubuntu 12.04 VM.
  * The AMBER energy calculator referenced in protein-shop/lib/input/README is as yet unexplored.
  * Allowing ProteinShop to specify a path to its configuration file would be nice.
  * Other tidying up of execution behavior, such as directing or configuring output, would also be good.
  * Other tidying up of the ProteinShop folders to strip out possible build and test files.
  * Any sort of extensive testing has yet to happen.

This is a Fork of the ProteinShop Code
--------------------------------------

Changes have been made to the ProteinShop Makefile.

  * Switch to using gfortran rather than g77.

Licensing Details
-----------------

Everything under /protein-shop is GPL, everything else here is MIT.

Setup in Brief
--------------

  * Install the latest versions of Vagrant, Virtualbox, and Chef, and Librarian-chef.
  * Checkout this project.

Then on the command line in this project directory, execute the following
commands to install all the needed Chef cookbooks and fire up the CentOS virtual
machine:

    librarian-chef install
    vagrant up centos-6.4-x86_64

Vagrant will download a base virtual machine image the first time you do this,
then launch it and run a setup and provisioning process. The download and
provisioning only has to be done once (unless you destroy the VM and start over,
and even then Vagrant keeps a copy of the original downloaded base box).

Once launched you can log in to the machine with user `vagrant` and password
`vagrant`. Running this command in the project directory will also log you in
as user `vagrant` over SSH:

    vagrant ssh centos-6.4-x86_64

This user has full sudo rights, so you can upgrade to root access from the
command line with `sudo su` as usual.

What Happens if Vagrant Setup Fails?
------------------------------------

Using Vagrant to manage a VM that has a GUI is less reliable than using a
headless VM. You will see the occasional failures wherein Vagrant fails to
establish a connection to the server or fails to detect when the boot process
completes.

Similar, the provisioning process requires downloading software from the
internet, and that also sometimes fails.

If either of these things happens, then you will see red error messages from
Vagrant. The best thing to do at that point is to force halt the VM and then
retry, rerunning the provisioning if it hasn't yet completed:

    vagrant halt -f centos-6.4-x86_64
    vagrant up --provision centos-6.4-x86_64

ProteinShop Build Dependencies
------------------------------

For CentOS 6.4:

    sudo yum install gcc-gfortran freeglut-devel fltk-devel fltk-fluid

You will have to [add the remi and epel repositories](http://www.rackspace.com/knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x)
to get access to many of the dependencies.

For Ubuntu 12.04:

    sudo apt-get install gfortran binutils-gold freeglut3-dev libfltk1.3-dev fluid

Unfortunately this Ubuntu build appears to have issues; it compiles correctly,
but fails to run. More investigation is needed.

Building ProteinShop
--------------------

After you are set up and the VM is running, you will find this project directory
shared with the VM under `/vagrant`. So the ProteinShop installation will be
under `/vagrant/protein-shop`.

To build the ProteinShop executable log in to the VM as user `vagrant` with
password `vagrant`. Then on the command line:

    cd /vagrant/protein-shop/src
    make clean
    make

The ProteinShop source is a mix of C and Fortran 77 code. The original Fortran
compiler used was g77, but getting this installed on modern *NIX machines is a
real pain, so it has been replaced by gfortran.

Using ProteinShop
-----------------

To get ProteinShop running with sample protein data for Ubiquitin, you must
log in to the VM GUI as the `vagrant` user, open a command prompt, and run
these commands:

    cd /vagrant/protein-shop/bin
    ./ProteinShop ../data/1UBQ.pdb

Note that you have to run the ProteinShop executable in the same directory as
the ProteinShop.cfg configuration file, which is located at
`/vagrant/protein-shop/bin/ProteinShop.cfg`.

General Pointers for Installing Vagrant, Virtualbox, and Chef
-------------------------------------------------------------

You will need later versions than are probably available in the package
respositories for your OS as of late 2013. Go to the source to get the latest
stable builds and installers:

  * [Vagrant downloads](http://downloads.vagrantup.com/)
  * [Virtualbox downloads](https://www.virtualbox.org/wiki/Downloads)
  * [Chef Client downloads](http://www.opscode.com/chef/install/)

At minimum you will need Vagrant 1.3.4, Chef 11.6.0, and Virtualbox 4.2.*.

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
