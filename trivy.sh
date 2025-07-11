#steps to install trivy:
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.tar.gz
tar zxvf trivy_0.18.3_Linux-64bit.tar.gz
chmod +x trivy
sudo mv trivy /usr/local/bin/
vim .bashrc
export PATH=$PATH:/usr/local/bin/
source .bashrc 
