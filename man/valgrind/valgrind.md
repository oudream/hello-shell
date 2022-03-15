

### 这里是测试的一个C程序例子
```c
#include <stdlib.h>
#include <stdio.h>
void func()
{
 //只申请内存而不释放
    void *p=malloc(sizeof(int));
}
int main()
{
    func();
    getchar();
    return 0;
}
```
```shell
gcc -o ./a.out ./main.c
valgrind --log-file=valReport --leak-check=full --show-reachable=yes --leak-resolution=low ./a.out
```
```text
–log-file=valReport 是指定生成分析日志文件到当前执行目录中，文件名为valReport
–leak-check=full 显示每个泄露的详细信息
–show-reachable=yes 是否检测控制范围之外的泄漏，比如全局指针、static指针等，显示所有的内存泄露类型
–leak-resolution=low 内存泄漏报告合并等级
```