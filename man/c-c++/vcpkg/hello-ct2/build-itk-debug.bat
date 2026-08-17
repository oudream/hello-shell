@echo off
setlocal

rem ===============================
rem 配置路径
rem ===============================
set SRC=D:\ct\hello-ct2\3rd\itk
set BLD=D:\ct\hello-ct2\3rd\itk-build
set PKG=D:\ct\hello-ct2\3rd\itk-install

rem ===============================
rem 生成构建目录
rem ===============================
if not exist "%BLD%" (
    mkdir "%BLD%"
)

rem ===============================
rem 配置 ITK (使用 Visual Studio 2022 生成器)
rem ===============================
cmake -S "%SRC%" -B "%BLD%" ^
  -G "Visual Studio 17 2022" -A x64 ^
  -DBUILD_SHARED_LIBS=ON ^
  -DCMAKE_INSTALL_PREFIX="%PKG%" ^
  -DCMAKE_DEBUG_POSTFIX=d

if errorlevel 1 (
    echo [ERROR] CMake configure 失败
    exit /b 1
)

rem ===============================
rem 编译 Release 并安装
rem ===============================
cmake --build "%BLD%" --config Release --target INSTALL -j 8
if errorlevel 1 (
    echo [ERROR] Release 构建或安装失败
    exit /b 1
)

rem ===============================
rem 编译 Debug 并安装
rem ===============================
cmake --build "%BLD%" --config Debug --target INSTALL -j 8
if errorlevel 1 (
    echo [ERROR] Debug 构建或安装失败
    exit /b 1
)

echo.
echo ===============================
echo ITK 已成功安装到: %PKG%
echo bin/, lib/, include/, share/ 等目录已生成
echo ===============================

endlocal
