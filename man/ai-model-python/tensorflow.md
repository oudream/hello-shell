### 创建虚拟环境：
```shell
conda create -n envs python==3.7
#conda create -n env_hp python==3.7
#conda create --name env_hp python=3.7
conda activate envs

#更换国内清华源：
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
#激活安装源：
conda config --set show_channel_urls yes

#安装三方库：
#先装tensorflow
conda install tensorflow=2.6.0
conda install numpy=1.19.5
conda install pandas=1.2.3
conda install requests=2.28.1
conda install -c conda-forge schedule=1.2.1
conda install scikit-learn==1.0.2
conda install matplotlib==3.5.3
pip3 install openpyxl
```

pip3 install tensorflow
pip3 install numpy
pip3 install pandas
pip3 install requests
pip3 install schedule
pip3 install scikit-learn
pip3 install matplotlib
pip3 install openpyxl
