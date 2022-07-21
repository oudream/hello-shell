#!/usr/bin/env bash


docker-compose up -d
# force recreate
docker-compose up -d --force-recreate --build


docker-compose build
docker-compose kill -s SIGINT
docker-compose run ubuntu ping docker.com
docker-compose run --no-deps web python manage.py shell
docker-compose scale web=2 worker=3
docker-compose up # 将会整合所有容器的输出，并且退出时，所有容器将会停止。
docker-compose up -d # 将会在后台启动并运行所有的容器。


# docker run == docker-compose.yml


docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]
docker-compose -h|--help

#Options:
  -f, --file FILE             Specify an alternate compose file
#                             (default: docker-compose.yml)
  -p, --project-name NAME     Specify an alternate project name
#                             (default: directory name)
  --verbose                   Show more output
  --log-level LEVEL           Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
  --no-ansi                   Do not print ANSI control characters
  -v, --version               Print version and exit
  -H, --host HOST             Daemon socket to connect to

  --tls                       Use TLS; implied by --tlsverify
  --tlscacert CA_PATH         Trust certs signed only by this CA
  --tlscert CLIENT_CERT_PATH  Path to TLS certificate file
  --tlskey TLS_KEY_PATH       Path to TLS key file
  --tlsverify                 Use TLS and verify the remote
  --skip-hostname-check       Don't check the daemon's hostname against the
#                             name specified in the client certificate
  --project-directory PATH    Specify an alternate working directory
#                             (default: the path of the Compose file)
  --compatibility             If set, Compose will attempt to convert keys
#                             in v3 files to their non-Swarm equivalent
  --env-file PATH             Specify an alternate environment file

#Commands:
  build              Build or rebuild services
  config             Validate and view the Compose file
  create             Create services
  down               Stop and remove containers, networks, images, and volumes
  events             Receive real time events from containers
  exec               Execute a command in a running container
  help               Get help on a command
  images             List images
  kill               Kill containers
  logs               View output from containers
  pause              Pause services
  port               Print the public port for a port binding
  ps                 List containers
  pull               Pull service images
  push               Push service images
  restart            Restart services
  rm                 Remove stopped containers
  run                Run a one-off command
  scale              Set number of containers for a service
  start              Start services
  stop               Stop services
  top                Display the running processes
  unpause            Unpause services
  up                 Create and start containers
  version            Show the Docker-Compose version information


### install
# https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
### windows
mklink "C:\ProgramData\DockerDesktop\version-bin\docker-compse" "C:\Program Files\Docker\Docker\resources\bin\docker-compose"
mklink "C:\ProgramData\DockerDesktop\version-bin\docker-compse.exe" "C:\Program Files\Docker\Docker\resources\bin\docker-compose.exe"
