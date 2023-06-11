
# https://docs.docker.com/engine/install/binaries/
#
# https://download.docker.com/linux/static/stable/aarch64/
#
# https://blog.csdn.net/qq_50007696/article/details/122667353

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
for pkg in docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; do sudo apt-get remove $pkg; done
for pkg in containerd containerd-shim ctr docker docker-init docker-proxy dockerd runc; do sudo rm -rf /usr/bin/$pkg; done
apt-get clean

wget https://download.docker.com/linux/static/stable/aarch64/docker-18.09.9.tgz
tar -xf docker-18.09.9.tgz
# 29000 -rwxr-xr-x 1 linaro linaro 29693824 Sep  4  2019 containerd*
  # 5360 -rwxr-xr-x 1 linaro linaro  5485216 Sep  4  2019 containerd-shim*
  #16184 -rwxr-xr-x 1 linaro linaro 16570048 Sep  4  2019 ctr*
  #44568 -rwxr-xr-x 1 linaro linaro 45636144 Sep  4  2019 docker*
  #  536 -rwxr-xr-x 1 linaro linaro   546520 Sep  4  2019 docker-init*
  # 2692 -rwxr-xr-x 1 linaro linaro  2756125 Sep  4  2019 docker-proxy*
  #56912 -rwxr-xr-x 1 linaro linaro 58275504 Sep  4  2019 dockerd*
  # 7328 -rwxr-xr-x 1 linaro linaro  7500480 Sep  4  2019 runc*
mv docker/* /usr/bin/

vi /lib/systemd/system/docker.service
vi /lib/systemd/system/docker.socket

groupadd docker
useradd docker -g docker

systemctl daemon-reload
systemtl start docker

docker version