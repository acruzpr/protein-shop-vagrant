# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ensure that we update the version of Chef on the guest machine. This has to
  # be a separate provision statement issued before the real provisioning
  # starts. This is because the version won't update until a new provisioning
  # block begins.
  #
  # Note that we can't use environments here, as the version of Chef might be
  # too early to support it (pre-11.6.0).
  config.vm.provision :chef_solo do |chef|
    # Set the log level.
    #chef.log_level = "debug"
    # Set the paths.
    chef.cookbooks_path = "./cookbooks"
    # Specify the recipe and pass in attributes directly.
    chef.run_list = [
      "recipe[chef_update]"
    ]
    chef.json = {
      "chef_update" => {
        "minimum_version" => {
          "major" => 11,
          "minor" => 6
        }
      }
    }
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  config.vm.provision :chef_solo do |chef|
    # Set the log level.
    chef.log_level = "debug"
    # Set the paths.
    chef.cookbooks_path = "./cookbooks"
    chef.roles_path = "./roles"
    chef.environments_path = "./environments"
    # The environment provides all the necessary attributes.
    chef.environment = "local-virtual"
    # Includes all of the necessary recipes.
    chef.add_role("protein-shop")
  end

  # With 64-bit CentOS as the OS.
  #
  # Note that this box has gdm installed already, making the addition of a GUI
  # pretty painless. A CentOS box without that would require additions to the
  # provisioning recipes.
  config.vm.define "centos-6.4-x86_64" do |subconfig|

    subconfig.vm.box = "centos_6.4-x86_64"
    subconfig.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    subconfig.vm.network :private_network, ip: "192.168.34.10"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    subconfig.vm.provider :virtualbox do |vb|
      # Don't boot with headless mode
      vb.gui = true

      # Use VBoxManage to customize the VM.
      #
      # This fixes some kinds of issue that occur when using a GUI where Vagrant
      # fails to establish a connection to the VM and the VM networking fails.
      # https://github.com/mitchellh/vagrant/issues/391
      #
      # CentOS is apparently more flaky in this regard than other distros.
      vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
      vb.customize ["modifyvm", :id, "--natnet1", "192.168/16"]
      # More memory is good.
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  # With 64-bit Ununtu 12.04 as the OS.
  #
  # TODO: Never did get this to work in the short time I looked at it:
  #
  # 1) The GUI desktop/DM installation didn't come to a good resolution, in that
  #    it worked on provisioning, but then failed on reboot.
  # 2) ProteinShop compiled but failed on running with a buffer overflow.
  #
  #config.vm.define "ubuntu-precise-x86_64" do |subconfig|
  #
  #  subconfig.vm.box = "precise64"
  #  subconfig.vm.box_url = "http://files.vagrantup.com/precise64.box"
  #
  #  # Create a private network, which allows host-only access to the machine
  #  # using a specific IP.
  #  subconfig.vm.network :private_network, ip: "192.168.34.11"
  #
  #  # Provider-specific configuration so you can fine-tune various
  #  # backing providers for Vagrant. These expose provider-specific options.
  #  subconfig.vm.provider :virtualbox do |vb|
  #    # Don't boot with headless mode
  #    vb.gui = true
  #
  #    # Use VBoxManage to customize the VM.
  #    #
  #    # This fixes some kinds of issue that occur when using a GUI where Vagrant
  #    # fails to establish a connection to the VM and the VM networking fails.
  #    # https://github.com/mitchellh/vagrant/issues/391
  #    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
  #    vb.customize ["modifyvm", :id, "--natnet1", "192.168/16"]
  #    # More memory is good.
  #    vb.customize ["modifyvm", :id, "--memory", "2048"]
  #  end
  #end

end
