#!/bin/bash
sudo -i
# Initializing Kubernetes Master Node
sudo kubeadm init --apiserver-advertise-address=192.168.100.20 --pod-network-cidr=192.168.0.0/16

# Configure kubectl for the user
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Apply Calico CNI (Container Network Interface)
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
#kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Extract token and discovery-token-ca-cert-hash for joining worker nodes
#TOKEN=$(sudo kubeadm token create)
#HASH=$(sudo openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
    #sudo openssl rsa -pubin -outform der | \
    #sudo sha256sum | \
    #awk '{print $1}')

# Save the token and hash to a file (e.g., to send to worker nodes later)
#echo "kubeadm join $(hostname -I | awk '{print $1}'):6443 --token $TOKEN --discovery-token-ca-cert-hash sha256:$HASH" > join_command.txt
#echo "The join command has been saved to join_command.txt"

# if u want delete kluster
#sudo kubeadm reset
#sudo rm -rf /etc/kubernetes
#sudo rm -rf /var/lib/etcd
#sudo rm -rf ~/.kube
#sudo lsof -i :6443
#sudo lsof -i :10250
#sudo lsof -i :2379

#mkdir -p keys
#sudo cp /vagrant/.vagrant/machines/kubenode1/virtualbox/private_key /home/vagrant/keys/kubenode1-key.pem
#sudo cp /vagrant/.vagrant/machines/kubenode2/virtualbox/private_key /home/vagrant/keys/kubenode2-key.pem
#sudo chmod 600 /home/vagrant/keys/kubenode1-key.pem
#sudo chmod 600 /home/vagrant/keys/kubenode2-key.pem
#sudo scp -o StrictHostKeyChecking=no -i /home/vagrant/keys/kubenode1-key.pem join_command.txt vagrant@192.168.100.22:/home/vagrant/
#sudo scp -o StrictHostKeyChecking=no -i /home/vagrant/keys/kubenode2-key.pem join_command.txt vagrant@192.168.100.24:/home/vagrant/
#echo "Join command has been successfully copied to the worker node."