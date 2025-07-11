#! /bin/bash

#install java
yum install java-17-amazon-corretto -y

#install git
yum install git -y

#install jenikins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
sudo yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
