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
    db01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      sudo dnf update -y
      sudo dnf install epel-release -y
      sudo dnf install mariadb-server git -y
      sudo systemctl start mariadb
      sudo systemctl enable mariadb
      #sudo mysql_secure_installation  # Uncomment to secure MariaDB
      sudo cp /vagrant/set-db.sh /root/
      chmod +x /root/set-db.sh
      sudo /root/set-db.sh
      sudo rm -rf set-db.sh
      cd /tmp/
      git clone -b 1.Multi-Tier-Web-Application-Setup,-Locally https://github.com/Dev-Anas-10/20DevOpsProject.git
      cd 20DevOpsProject
      mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql
      sudo systemctl restart mariadb
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
    mc01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      sudo dnf update -y
      sudo dnf install epel-release -y
      sudo dnf install -y memcached libevent
      sudo systemctl start memcached
      sudo systemctl enable memcached
      sudo sed -i 's/-l 127.0.0.1/-l 0.0.0.0/' /etc/sysconfig/memcached  # Listen on all interfaces
      sudo systemctl restart memcached
      sudo memcached -p 11211 -U 11111 -u memcached -d
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
    rmq01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      sudo dnf update -y
      sudo dnf install epel-release -y
      sudo dnf install wget -y
      sudo dnf -y install centos-release-rabbitmq-38
      sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server
      sudo systemctl enable --now rabbitmq-server
      sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
      sudo rabbitmqctl add_user test test
      sudo rabbitmqctl set_user_tags test administrator
      sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
      sudo systemctl restart rabbitmq-server
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
    app01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      sudo cp /vagrant/tomcat-setup.sh /root/
      sudo chmod +x /root/tomcat-setup.sh
      sudo /root/tomcat-setup.sh

      # Navigate to the /tmp/ directory
      cd /tmp/

      # Download Maven
      wget https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip

      # Unzip the downloaded Maven package
      unzip apache-maven-3.9.9-bin.zip

      # Copy Maven to the desired directory
      sudo cp -r apache-maven-3.9.9 /usr/local/maven3.9

      # Set MAVEN_OPTS environment variable
      export MAVEN_OPTS="-Xmx512m"

      cd /tmp/
      sudo git clone -b 1.Multi-Tier-Web-Application-Setup,-Locally https://github.com/Dev-Anas-10/20DevOpsProject.git
      cd 20DevOpsProject
      #vim src/main/resources/application.properties  # Update file with backend server details
      sudo /usr/local/maven3.9/bin/mvn install
      sudo systemctl stop tomcat
      sudo rm -rf /usr/local/tomcat/webapps/ROOT*
      sudo cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
      sudo systemctl start tomcat
      sudo chown tomcat.tomcat /usr/local/tomcat/webapps -R
      sudo systemctl restart tomcat
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
    web01.vm.provision "shell", inline: <<-SHELL
      #!/bin/bash
      sudo cp /vagrant/nginx-setup.sh /root/
      sudo chmod +x /root/nginx-setup.sh
      sudo /root/nginx-setup.sh
    SHELL
  end
end
