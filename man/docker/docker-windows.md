
### �� Windows װ�� Docker ������
- https://github.com/dockur/windows
- docker-compose.yml
```yaml
version: "3"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    devices:
      - /dev/kvm
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    stop_grace_period: 2m
    restart: on-failure
```

```shell
docker compose up
```

- docker-compose.yml
```yaml
version: "3"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "win10"
    devices:
      - /dev/kvm
    cap_add:
      - NET_ADMIN
    ports:
      - 8006:8006
      - 3389:3389/tcp
      - 3389:3389/udp
    stop_grace_period: 2m
    restart: on-failure
```

- docker network ls
```shell
docker network ls

docker network rm <network_name>

docker network rm docker-windows_default
docker network create --subnet=192.168.55.0/24 --gateway=192.168.55.1 --driver bridge docker-windows_default
docker network connect docker-windows_default <container_id> # �������������ӵ��µ�����
```
```yaml
version: "3"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "win10"
    devices:
      - /dev/kvm
    cap_add:
      - NET_ADMIN
    ports:
      - "4106:8006"
      - "4189:3389/tcp"
      - "4189:3389/udp"
    stop_grace_period: 2m
    restart: on-failure
    networks:
      - docker-windows_default

networks:
  docker-windows_default:
    external: true

```

- �� Docker ���������Կ�
- 1. ��װ NVIDIA Container Toolkit
```shell
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit-base nvidia-docker2
```
- ʹ�ô���
```shell
curl -x http://192.168.133.24:7890 -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -x http://192.168.133.24:7890 -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt -o Acquire::http::proxy="http://192.168.133.24:7890" update	

apt -o Acquire::http::proxy="http://192.168.133.24:7890" install -y nvidia-container-toolkit

sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

rm /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
rm /etc/apt/sources.list.d/nvidia-container-toolkit.list
```
- 2. ���� Docker ʹ�� NVIDIA runtime�������ļ�λ�� /etc/docker/daemon.json��ȷ���������������ݣ�
```json
{
  "default-runtime": "nvidia",
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
}
```
- ����
```shell
sudo systemctl restart docker
```
- ��֤����������ʾ�Կ���Ϣ��˵��������ȷ��
```shell
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
docker run --rm --gpus all --runtime=nvidia ubuntu nvidia-smi
```
- docker-compose.yml
```yaml
version: "3.8"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "win10"
      # ָ��Ҫʹ�õ� GPU ����
      NVIDIA_VISIBLE_DEVICES: "2"
    devices:
      - /dev/kvm
    cap_add:
      - NET_ADMIN
    ports:
      - "4106:8006"
      - "4189:3389/tcp"
      - "4189:3389/udp"
    stop_grace_period: 2m
    restart: on-failure
    networks:
      - docker-windows_default
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: ["gpu"]

networks:
  docker-windows_default:
    external: true
```
```shell
docker compose up -d
```
- ����Կ�����
- ȷ���� 3 ���Կ�������Ϊ 2����Ϊ GPU �����Ǵ� 0 ��ʼ����ġ�����ͨ��������������鿴ϵͳ�������Կ���������
```shell
nvidia-smi
```



```yaml
version: "3.8"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    privileged: true
    environment:
      VERSION: "win11"
      DEBUG: "Y"
      RAM_SIZE: "16G"
      CPU_CORES: "14"
      ARGUMENTS: "-device vfio-pci,host=d9:00.0,multifunction=on -device vfio-pci,host=b1:00.0,multifunction=on"
    devices:
      - /dev/kvm
      - /dev/vfio/1
    group_add:
      - "105"
    volumes:
      - ./storage:/storage
    cap_add:
      - NET_ADMIN
    ports:
      - "8006:8006"
      - "3389:3389/tcp"
      - "3389:3389/udp"
    stop_grace_period: 2m
    restart: on-failure

networks:
  docker-windows_default:
    external: true

```