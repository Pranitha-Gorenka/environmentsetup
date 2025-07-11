#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

#! /bin/bash

#install java
yum install java-17-amazon-corretto -y
wget https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz
tar -xzf amazon-corretto-17-x64-linux-jdk.tar.gz
sudo mv amazon-corretto-17.* /opt/jdk-17

#install git
yum install git -y

#install docker
yum install docker -y

# start docker
systemctl start docker
systemctl status docker

# integrate to jennkins
chmod 777 ///var/run/docker.sock

#install jenikins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
sudo yum install jenkins -y


# start jenkins
systemctl start Jenkins.service

#install sonarqube
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
Access the sonarqube by <server-ip:9000>

#steps to install trivy:
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.tar.gz
tar zxvf trivy_0.18.3_Linux-64bit.tar.gz
chmod +x trivy
sudo mv trivy /usr/local/bin/

#! /bin/bash

#Download the AWS CLI:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#Unzip the downloaded file:
unzip awscliv2.zip
#Install AWS CLI:
sudo ./aws/install

#Download the latest version of kubectl:
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#Make it executable:
chmod +x kubectl
#Move it to the appropriate location:
sudo mv kubectl /usr/local/bin/

#Download the Kops binary:
uname -m
# For x86_64:
curl -Lo kops https://github.com/kubernetes/kops/releases/latest/download/kops-linux-amd64
#Make it executable:
chmod +x kops
#Move it to the appropriate location:
sudo mv kops /usr/local/bin/

#check versions
kops version
kubectl version


#creating a buckets and configure with cluster
aws s3api create-bucket --bucket prani77 --region us-east-1
aws s3api put-bucket-versioning --bucket prani77 --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://prani77

#creating the cluster
kops create cluster --name prani.k8s.local --zones us-east-1a,us-east-1b --master-size t2.medium --master-count 1 --master-volume-size 40 --node-size t2.medium --node-count 2 --node-volume-size 40
kops update cluster --name prani.k8s.local --yes --admin

TO DELETE THE CLUSTER 
export KOPS_STATE_STORE=s3://prani77
kops get cluster 
kops delete cluster prani.k8s.local --yes
