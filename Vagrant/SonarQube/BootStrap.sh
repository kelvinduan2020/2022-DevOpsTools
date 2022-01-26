# Docker
sudo apt-get update 
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
# Avoid Permission Denied Issue
sudo usermod -aG docker vagrant
newgrp docker

# SonarQube: http://192.168.0.103:9000
# Default Username: admin
# Default Password: admin
docker volume create sonarqube-conf 
docker volume create sonarqube-data
docker volume create sonarqube-logs
docker volume create sonarqube-extensions
mkdir /opt/sonarqube
ln -s /var/lib/docker/volumes/sonarqube-conf/_data /opt/sonarqube/conf
ln -s /var/lib/docker/volumes/sonarqube-data/_data /opt/sonarqube/data
ln -s /var/lib/docker/volumes/sonarqube-logs/_data /opt/sonarqube/logs
ln -s /var/lib/docker/volumes/sonarqube-extensions/_data /opt/sonarqube/extensions
docker run -d --rm --name sonarqube -p 9000:9000 -p 9092:9092 -v sonarqube-conf:/opt/sonarqube/conf -v sonarqube-data:/opt/sonarqube/data -v sonarqube-logs:/opt/sonarqube/logs -v sonarqube-extensions:/opt/sonarqube/extensions sonarqube
