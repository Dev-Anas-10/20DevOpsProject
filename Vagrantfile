Vagrant.configure("2") do |config|
  
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Configuration for kops VM
  config.vm.define "kops" do |kops|
    # Set hostname and base box
    kops.vm.hostname = "kops"
    kops.vm.box = "ubuntu/jammy64"  # Ubuntu 22.04 LTS

    # Network configuration
    kops.vm.network "private_network", ip: "192.168.56.20"
    kops.vm.network "public_network", ip: "192.168.100.20"

    # Provider-specific configuration (VirtualBox in this case)
    kops.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # Increased memory
      vb.cpus = "2"
    end

    # Provisioning script
    kops.vm.provision "shell", path: "kops-setup.sh"
    kops.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash

    SHELL
  end
end
