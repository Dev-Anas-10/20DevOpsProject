Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Configuration for Jenkins VM
  config.vm.define "jenkins" do |jenkins|
    # Set hostname and base box
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.box = "ubuntu/jammy64"  # Base box for Jenkins

    # Network configuration
    jenkins.vm.network "private_network", ip: "192.168.56.20"
    jenkins.vm.network "public_network", ip: "192.168.100.20"

    # Provider-specific configuration (VirtualBox in this case)
    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "2"
    end

    # Provisioning script for Jenkins
    jenkins.vm.provision "shell", path: "Jenkins-Setup.sh"
    jenkins.vm.provision "shell", path: "docker-setup.sh"
    jenkins.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      echo "Administrator password of jenkins is "
      echo "###############################################"
      cat /var/lib/jenkins/secrets/initialAdminPassword
      echo "###############################################"
      reboot

    SHELL
  end

  # Configuration for Nexus VM
  config.vm.define "nexus" do |nexus|
    # Set hostname and base box
    nexus.vm.hostname = "nexus"
    nexus.vm.box = "eurolinux-vagrant/centos-stream-9"  # Base box for Nexus

    # Network configuration
    nexus.vm.network "private_network", ip: "192.168.56.22"
    nexus.vm.network "public_network", ip: "192.168.100.22"

    # Provider-specific configuration (VirtualBox in this case)
    nexus.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = "2"
    end

    # Provisioning script for Nexus
    nexus.vm.provision "shell", path: "Nexus-Setup-JDK11.sh"
    nexus.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      echo "Your admin user password is"
      echo "###############################################"
      cat /opt/nexus/sonatype-work/nexus3/admin.password
      echo "###############################################"
      reboot

    SHELL
  end

  # Configuration for SonarQube VM
  config.vm.define "sonar" do |sonar|
    # Set hostname and base box
    sonar.vm.hostname = "sonar"
    sonar.vm.box = "ubuntu/jammy64"  # Base box for SonarQube

    # Network configuration
    sonar.vm.network "private_network", ip: "192.168.56.24"
    sonar.vm.network "public_network", ip: "192.168.100.24"

    # Provider-specific configuration (VirtualBox in this case)
    sonar.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = "2"
    end

    # Provisioning script for SonarQube
    sonar.vm.provision "shell", path: "Sonar-Setup.sh"
    sonar.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      reboot

    SHELL
  end
end