
### 教程：通过 vcpkg 安装和使用包
- https://learn.microsoft.com/zh-cn/vcpkg/get_started/get-started?pivots=shell-cmd
- https://learn.microsoft.com/zh-cn/vcpkg/

```shell
git clone https://github.com/microsoft/vcpkg.git
# 请导航到 vcpkg 目录并执行启动脚本：
# 运行启动脚本
cd vcpkg && bootstrap-vcpkg.bat

set VCPKG_ROOT="C:\path\to\vcpkg"
set PATH=%VCPKG_ROOT%;%PATH%
```