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

# Nexus: http://192.168.0.102:8081
# Default Username: admin
# Default Password: docker container exec nexus cat nexus-data/admin.password
# docker logs nexus -f : If see message stating "Started Sonatype Nexus OSS 3.34.0-01" means Nexus Repository Manager is ready to use
docker volume create nexus-data
sudo mkdir /opt/nexus
sudo ln -s /var/lib/docker/volumes/nexus-data/_data /opt/nexus/data
docker run -d --rm --name nexus -p 8081:8081 -p 8083:8083 -v nexus-data:/opt/nexus/data sonatype/nexus3

