# -*- mode: ruby -*-
# vi: set ft=ruby :

projectDir = "/dotafanwars_static"
provisionFile = "bootstrap.sh"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.env.enable

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", :disabled => true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |provider, override|
    override.vm.box = "ubuntu/trusty64"
    override.vm.hostname = ENV['DFWS_HOST']
    override.vm.synced_folder ".", projectDir, :nfs => true
    override.bindfs.bind_folder projectDir, projectDir

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    override.vm.network "forwarded_port", guest: ENV['DFWS_PORT'], host: ENV['DFWS_HOST_PORT']

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    override.vm.network "private_network", ip: "192.168.33.10"

    override.vm.provision :shell, path: provisionFile, args: [projectDir]

    provider.name = "dotafanwars_static"
    provider.cpus = ENV['DFWS_CPU_COUNT']
    provider.memory = ENV['DFWS_RAM']
  end

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    override.vm.synced_folder ".", projectDir, type: 'rsync', rsync__exclude: [".git/", ".vagrant/", "user-photos/*"]
    override.vm.provision :shell, path: provisionFile, args: [projectDir]

    provider.token = ENV['DFWS_DIGITAL_OCEAN_TOKEN']
    provider.image = ENV['DFWS_DIGITAL_OCEAN_IMAGE']
    provider.region = ENV['DFWS_DIGITAL_OCEAN_REGION']
    provider.size = ENV['DFWS_DIGITAL_OCEAN_RAM']
  end

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
