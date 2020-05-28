设置系统服务

sc config messenger start= demand  设置服务手动
sc config messenger start= DISABLED  设置服务禁用
sc config messenger start= AUTO 设置服务自动
net stop messenger  关闭服务
net start messenger 开启服务
--------------------------------------------------
start= {boot | system | auto | demand | disabled} 

指定服务的启动类型。 

 
值 描述 
boot
 由启动加载程序加载的设备驱动程序。
 
system
 在核心初始化过程中启动的设备驱动程序。
 
auto
 每次计算机重新启动时都会自动启动、并且即使无人登录到计算机也能正常运行的服务。
 
demand
 必须手动启动的服务。如果没有指定 start=，则此项即为默认值。
 
disabled
 不能启动的服务。要启动禁用的服务，应将启动类型更改为其他值。
