Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Configuration for db01 VM
  config.vm.define "db01" do |db01|
    db01.vm.hostname = "db01"
    db01.vm.box = "eurolinux-vagrant/centos-stream-9"  # Base box for db01

    # Network configuration
    db01.vm.network "private_network", ip: "192.168.56.20"
    db01.vm.network "public_network", ip: "192.168.100.20"

    # Provider-specific configuration (VirtualBox)
    db01.vm.provider "virtualbox" do |vb|
      vb.memory = "600"
      vb.cpus = "1"
    end

    # Provisioning script for db01
    db01.vm.provision "shell", path: "db01.sh"
    db01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
    SHELL
  end

  # Configuration for mc01 VM
  config.vm.define "mc01" do |mc01|
    mc01.vm.hostname = "mc01"
    mc01.vm.box = "eurolinux-vagrant/centos-stream-9"  # Base box for mc01

    # Network configuration
    mc01.vm.network "private_network", ip: "192.168.56.22"
    mc01.vm.network "public_network", ip: "192.168.100.22"

    # Provider-specific configuration (VirtualBox)
    mc01.vm.provider "virtualbox" do |vb|
      vb.memory = "600"
      vb.cpus = "1"
    end

    # Provisioning script for mc01
    mc01.vm.provision "shell", path: "mc01.sh"
    mc01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
    SHELL
  end

  # Configuration for rmq01 VM
  config.vm.define "rmq01" do |rmq01|
    rmq01.vm.hostname = "rmq01"
    rmq01.vm.box = "eurolinux-vagrant/centos-stream-9"  # Base box for rmq01

    # Network configuration
    rmq01.vm.network "private_network", ip: "192.168.56.24"
    rmq01.vm.network "public_network", ip: "192.168.100.24"

    # Provider-specific configuration (VirtualBox)
    rmq01.vm.provider "virtualbox" do |vb|
      vb.memory = "600"
      vb.cpus = "1"
    end

    # Provisioning script for rmq01
    rmq01.vm.provision "shell", path: "rmq01.sh"
    rmq01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
    SHELL
  end

  # Configuration for Tomcat VM
  config.vm.define "app01" do |app01|
    app01.vm.hostname = "app01"
    app01.vm.box = "eurolinux-vagrant/centos-stream-9"  # Base box for app01

    # Network configuration
    app01.vm.network "private_network", ip: "192.168.56.26"
    app01.vm.network "public_network", ip: "192.168.100.26"

    # Provider-specific configuration (VirtualBox)
    app01.vm.provider "virtualbox" do |vb|
      vb.memory = "800"
      vb.cpus = "2"
    end

    # Provisioning script for app01
    app01.vm.provision "shell", path: "app01.sh"
    app01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
    SHELL
  end

  # Configuration for Nginx VM
  config.vm.define "web01" do |web01|
    web01.vm.hostname = "web01"
    web01.vm.box = "ubuntu/jammy64"  # Base box for web01

    # Network configuration
    web01.vm.network "private_network", ip: "192.168.56.28"
    web01.vm.network "public_network", ip: "192.168.100.28"

    # Provider-specific configuration (VirtualBox)
    web01.vm.provider "virtualbox" do |vb|
      vb.memory = "800"
      vb.cpus = "2"
    end

    # Provisioning script for web01
    web01.vm.provision "shell", path: "web01.sh"
    web01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
    SHELL
  end
end
