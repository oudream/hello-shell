
### ubuntu ap
- https://blog.csdn.net/xuesong10210/article/details/130688576
- https://askubuntu.com/questions/490950/create-wifi-hotspot-on-ubuntu


### hostap 官网
- git://w1.fi/srv/git/hostap.git


### hostap github
- https://github.com/greearb/hostap-ct.git


### 
- https://www.cnblogs.com/chenxi188/p/10786195.html
- 客户端使用HOSTAPD无线AP时，网速不稳定
```text
3、客户端使用HOSTAPD无线AP时，网速不稳定

客户端使用HOSTAPD无线AP时，网速不稳定，导致某些时刻无法打开网页或者其它因为网络超时导致的网络不可访问故障。 

该问题主要是因为无线数据传输校验中随机种子数较少导致的无线网络数据传输时延过大导致的，
用户可以通过命令cat /proc/sys/kernel/random/entropy_avail来查看具体数值，该值一般小于1000，
用户需要通过在终端中执行sudo apt-get install haveged命令安装随机数生成器（haveged），
并使用/etc/init.d/haveged start命令来启动随机数生成器（haveged）提高entropy_avail数值。
这样无线网络时延将恢复到正常状态。网络不在出现以上描述的问题。
```