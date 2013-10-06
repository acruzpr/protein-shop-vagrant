ProteinShop With Vagrant
========================

[ProteinShop](http://proteinshop.org/) is a visualization tool for molecular
structure. It is no longer maintained.

This project offers an easy way to run ProteinShop on a local virtual machine
for the purposes of evaluation, curiosity, and so forth.

  * Vagrant is a tool for managing Virtualbox virtual machines.
  * Virtualbox runs virtual machines.
  * Chef is a provisioning tool for setting software on a machine.

Setup in Brief
--------------

  * Install the latest versions of Vagrant, Virtualbox, and Chef, and Librarian-chef
  * Checkout this project.
  * On the command line in this project directory:

    librarian-chef install
    vagrant plugin install vagrant-vbguest
    vagrant up centos-6.4-x86_64

A base virtual machine will download the first time you do this, then launch,
then run a setup process, then restart. In the future it will only have to
start up, not run all of the downloading and provisioning.

What Happens if Vagrant Setup Fails?
------------------------------------

Using Vagrant to manage a VM that has a GUI is less reliable than running VMs
headless. You will see a fair number of failures wherein Vagrant fails to
establish a connection to the server, or fails to detect when the boot process
completes.

Similar, the provisioning process requires downloading software from the
internet, and that can always fail.

If either of these things happens, then you will see red error messages from
Vagrant. The best thing to do at that point is to shut down the VM and
retry, rerunning the provisioning if it hasn't yet completed:

    vagrant halt -f centos-6.4-x86_64
    vagrant up --provision centos-6.4-x86_64

Using ProteinShop
-----------------

After you are set up, you will find this project directory shared with the
VM under /vagrant. So the ProteinShop installation will be under:

    /vagrant/protein-shop

To shut down the virtual machine use the following command:

    vagrant halt centos-6.4-x86_64

To see other commands:

    vagrant -h

To get ProteinShop running with sample protein data:

    cd  /vagrant/protein-shop/bin
    wget http://www.rcsb.org/pdb/download/downloadFile.do?fileFormat=pdb&compression=NO&structureId=1ubq
    ./ProteinShop 1UBQ.pdb

Instructions for Installing Vagrant, Virtualbox, and Chef on Ubuntu 13.04
-------------------------------------------------------------------------

The Vagrant setup uses simple common base VMs and Chef to provision them by
enacting recipes in cookbooks.

Librarian is a tool for easily managing cookbook sets, automatically downloading
them for you based on a config file.

    sudo apt-get install chef ruby1.9.1-dev
    sudo gem install librarian-chef

Download the latest Vagrant .deb file from http://www.vagrantup.com. Don't use
the Vagrant version in the Ubuntu repositories because it's too old. It doesn't
have support for Chef environments, and uses the v1 rather than v2 Vagrantfile
format.

For Virtualbox, do the following to get a suitably recent version.

1) Add this line to /etc/apt/sources.list

    deb http://download.virtualbox.org/virtualbox/debian raring contrib

Then run:

    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install virtualbox-4.2
