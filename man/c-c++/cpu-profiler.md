

### 性能测试工具CPU profiler(gperftools)
- https://github.com/gperftools/gperftools
```shell
# 从github下载gperftools源码并解压
wget https://github.com/gperftools/gperftools/archive/gperftools-2.7.tar.gz
tar xvf gperftools-2.7.tar.gz
# 解压文件夹改名
mv gperftools-gperftools-2.7 gperftools-2.7
cd gperftools-2.7
./autogen.sh
./configure
make -j 8
# 安装到系统文件夹
sudo make install
```


```c
#include <gperftools/profiler.h>
....
int main(int argc, const char* argv[])
{
	ProfilerStart("test_capture.prof");
	.....
	ProfilerStop();
}
```

```shell
# 加上-lprofiler编译自己的程序
gcc [...] -o myprogram -lprofiler
# 设置环境变量CPUPROFILER指定生成的性能报告文件，并执行自己的程序
CPUPROFILE=/tmp/profile ./myprogram

```

### 有了性能报告 ，就可以用gperftools提供的性能分析工具pprof生成直观可读的文件形式。
```shell
# 生成性能报告（层次调用节点有向图）输出到web浏览器显示
# 第一个参数为你的可执行程序或动态库文件名，第二个参数为上一步生成的性能报告文件
pprof  ./test_capture test_capture.prof --web
```


### update std-c++
- https://www.jianshu.com/p/32a86bb08685
```shell
# 将下载的包放到 /usr/lib64 下
cp libstdc++.so.6.0.26 /usr/lib64/
# 到 /usr/lib64 目录下
cd /usr/lib64/
# 删除
rm -rf libstdc++.so.6
# 重新链接
ln -s libstdc++.so.6.0.26 libstdc++.so.6
# 查询升级后是否是我们想要的
strings libstdc++.so.6 | grep GLIBCXX
```
