
# https://docs.gitlab.com/ee/install/docker.html

# https://caojie.blog/?p=1855

mkdir -pv /userdata/gitlab

docker run --detach \
  --hostname 10.50.52.235 \
  -p 50443:443 \
  -p 50080:80 \
  -p 50022:22 \
  --name gitlab \
  --restart always \
  -v /userdata/gitlab/config:/etc/gitlab \
  -v /userdata/gitlab/logs:/var/log/gitlab \
  -v /userdata/gitlab/data:/var/opt/gitlab \
  -v /etc/localtime:/etc/localtime \
  gitlab/gitlab-ce:15.6.7-ce.0


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
