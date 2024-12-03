Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Configuration for kubemaster VM
  config.vm.define "kubemaster" do |kubemaster|
    # Set hostname and base box
    kubemaster.vm.hostname = "kubemaster"
    kubemaster.vm.box = "ubuntu/jammy64"  # Base box for kubemaster

    # Network configuration
    kubemaster.vm.network "private_network", ip: "192.168.56.20"
    kubemaster.vm.network "public_network", ip: "192.168.100.20"

    # Provider-specific configuration (VirtualBox in this case)
    kubemaster.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = "2"
    end

    # Provisioning script for kubemaster
    kubemaster.vm.provision "shell", path: "kubeadm-setup.sh"
    kubemaster.vm.provision "shell", path: "kubemaster.sh"
    kubemaster.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash

    SHELL
  end



  # Configuration for kubenode1 VM
  config.vm.define "kubenode1" do |kubenode1|
    # Set hostname and base box
    kubenode1.vm.hostname = "kubenode1"
    kubenode1.vm.box = "ubuntu/jammy64"  # Base box for kubenode1

    # Network configuration
    kubenode1.vm.network "private_network", ip: "192.168.56.22"
    kubenode1.vm.network "public_network", ip: "192.168.100.22"

    # Provider-specific configuration (VirtualBox in this case)
    kubenode1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
    end

    # Provisioning script for kubenode1
    kubenode1.vm.provision "shell", path: "kubeadm-setup.sh"
    #kubenode1.vm.provision "shell", path: "kubenode.sh"
    kubenode1.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash

    SHELL
  end



  # Configuration for kubenode2Qube VM
  config.vm.define "kubenode2" do |kubenode2|
    # Set hostname and base box
    kubenode2.vm.hostname = "kubenode2"
    kubenode2.vm.box = "ubuntu/jammy64"  # Base box for kubenode2Qube

    # Network configuration
    kubenode2.vm.network "private_network", ip: "192.168.56.24"
    kubenode2.vm.network "public_network", ip: "192.168.100.24"

    # Provider-specific configuration (VirtualBox in this case)
    kubenode2.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
    end

    # Provisioning script for kubenode2Qube
    kubenode2.vm.provision "shell", path: "kubeadm-setup.sh"
    #kubenode2.vm.provision "shell", path: "kubenode.sh"
    kubenode2.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash

    SHELL
  end
end