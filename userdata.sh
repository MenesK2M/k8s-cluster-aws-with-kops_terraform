#!/bin/bash
sudo apt update
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo -i
useradd -m -d /home/ansadmin -c "k8s boootstrap user ansadmin" -s /bin/bash ansadmin
echo "ansadmin:test123" | sudo chpasswd
echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo sed -i '57s/no/yes/' /etc/ssh/sshd_config
sudo systemctl reload sshd
su - ansadmin

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

sudo curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
sudo chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

sudo mkdir /home/ansadmin/.aws/
sudo touch /home/ansadmin/.aws/config
sudo chmod 775 /home/ansadmin/.aws/
sudo chmod 600 /home/ansadmin/.aws/config
sudo chown -R ansadmin:ansadmin /home/ansadmin/.aws/
sudo echo -e "[default]\nregion = us-east-1\noutput = json" > /home/ansadmin/.aws/config

#sudo touch /home/ansadmin/.bash_profile
#sudo chown ansadmin:ansadmin /home/ansadmin/.bash_profile
#sudo chmod 664 /home/ansadmin/.bash_profile

echo 'export CLUSTER_NAME=useast1m.k8s.uct.in' > /home/ansadmin/.bash_profile
echo 'export KOPS_STATE_STORE=s3://useast1m.k8s.uct.in' >> /home/ansadmin/.bash_profile

sudo mkdir /home/ansadmin/.ssh
ssh-keygen -t rsa -f /home/ansadmin/.ssh/id_rsa -N ''
sudo chown -R ansadmin: /home/ansadmin/.ssh
sudo chmod 700 /home/ansadmin/.ssh/

