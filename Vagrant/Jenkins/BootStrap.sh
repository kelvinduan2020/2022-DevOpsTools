# Java
sudo apt update -y
#sudo apt install openjdk-8-jdk openjdk-8-jre -y 
sudo apt install openjdk-11-jdk -y

# Maven & Gradle& Git & Unzip
sudo apt install git maven unzip -y
wget https://services.gradle.org/distributions/gradle-7.3.3-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-*.zip
export PATH=$PATH:/opt/gradle/gradle-7.3.3/bin

# Jenkins
wget https://updates.jenkins-ci.org/download/war/2.330/jenkins.war
nohup java -jar jenkins.war &

# Docker
sudo apt-get update 
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker vagrant
newgrp docker

# Helm & Datree.io
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh
sudo helm plugin install https://github.com/datreeio/helm-datree
