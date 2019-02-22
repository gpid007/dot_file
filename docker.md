# Docker tutorial

## Resources
```
https://docs.docker.com/engine/docker-overview/
https://hub.docker.com/r/amancevice/superset/
```

## Setup
```bash
sudo yum update -y
sudo yum install -y git tmux

git config --global credential.helper store
sudo amazon-linux-extras install docker -y

sudo systemctl start docker
#sudo service docker start

sudo usermod -aG docker ec2-user

sudo reboot
#sudo init 6

sudo systemctl start docker
#sudo service docker start

cat <<EOF> my.csv
a,b,c
1,2,3
4,5,6
7,8,9
EOF

docker pull amancevice/superset
docker run -d --name mysuper -p 80:8088 -v $HOME:/mnt/ec2-user amancevice/superset:latest
# -d daemonized; --name giveName; -p Port=host:container; -v volume; image
watch docker ps

docker exec -it mysuper superset-init
docker exec -it mysuper superset load_examples
# check ip in aws console

docker exec -u 0 -it mysuper /bin/bash
```
