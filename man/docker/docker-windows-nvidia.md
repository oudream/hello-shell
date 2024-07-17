

https://soulteary.com/2024/03/11/install-windows-into-a-docker-container.html

http://192.168.133.17:4106

Administrator
Cyg***

https://github.com/dockur/windows/issues/22
https://github.com/dockur/windows/

https://developer.nvidia.com/blog/gpu-containers-runtime/

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

curl -x http://192.168.133.24:7890 -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -x http://192.168.133.24:7890 -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt -o Acquire::http::proxy="http://192.168.133.24:7890" update	

apt -o Acquire::http::proxy="http://192.168.133.24:7890" install -y nvidia-container-toolkit

sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

rm /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
rm /etc/apt/sources.list.d/nvidia-container-toolkit.list

4GPUµÄ·þÎñÆ÷£º192.168.133.17

