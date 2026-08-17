
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


- hello world
- 安装第三方库
```shell
vcpkg install --triplet x64-windows
```
```shell
#打开 “x64 Native Tools Command Prompt for VS 2022”。

#设定 vcpkg 根目录（若还没设）：
set VCPKG_ROOT=D:\Software\vcpkg
%VCPKG_ROOT%\bootstrap-vcpkg.bat

#在你的工程目录（含 vcpkg.json 的那个）执行 不带包名的安装：
vcpkg install --triplet x64-windows
#（若想静态库就用 --triplet x64-windows-static）

#CMake 配置（你已选 Ninja 生成器，Ninja 已在 PATH 就不必再指定）：
cmake --preset default

#如果仍报 “CMAKE_MAKE_PROGRAM is not set”，就加一条指定：
cmake --preset default -D CMAKE_MAKE_PROGRAM="D:/Software/MicrosoftVisualStudio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/Ninja/ninja.exe"

#构建：
cmake --build build --config Release
```