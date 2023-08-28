
# https://docs.gitlab.com/ee/install/docker.html

# https://caojie.blog/?p=1855

mkdir -pv /userdata/gitlab

docker run \
 -itd  \
 -p 9980:9980 \
 -p 9922:9922 \
 --hostname 10.50.52.210 \
 -v /home/gitlab/etc:/etc/gitlab  \
 -v /home/gitlab/log:/var/log/gitlab \
 -v /home/gitlab/opt:/var/opt/gitlab \
 --restart always \
 --name gitlab \
 gitlab/gitlab-ce:15.6.7-ce.0

docker run --detach \
  --hostname 10.8.8.6 \
  -p 9443:443 \
  -p 9980:80 \
  -p 9922:22 \
  --name gitlab \
  --restart always \
  -v /data/gitlab/config:/etc/gitlab \
  -v /data/gitlab/logs:/var/log/gitlab \
  -v /data/gitlab/data:/var/opt/gitlab \
  -v /etc/localtime:/etc/localtime \
  gitlab/gitlab-ce:latest


docker run --detach \
  --hostname 10.8.8.6 \
  -p 50443:443 \
  -p 50080:80 \
  -p 50022:22 \
  --name gitlab \
  --restart always \
  -v /data/gitlab/config:/etc/gitlab \
  -v /data/gitlab/logs:/var/log/gitlab \
  -v /data/gitlab/data:/var/opt/gitlab \
  -v /etc/localtime:/etc/localtime \
  gitlab/gitlab-ce:latest


sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ee:latest
