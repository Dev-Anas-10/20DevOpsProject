#!/bin/bash
sudo -i
# Reading the join command from the file
JOIN_COMMAND=$(cat /home/vagrant/join_command.txt)

# Execute the join command to join the worker node to the cluster
sudo $JOIN_COMMAND


kubeadm join 192.168.100.20:6443 --token ofz3m3.geqe362f1fsewa32 \
        --discovery-token-ca-cert-hash sha256:07e291ff447fba295f3ff9fb94b00f535c2cffba2e6002b10754ec31fb50288c