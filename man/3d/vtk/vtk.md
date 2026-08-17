

###
- https://www.kitware.eu/activiz/
- https://github.com/Kitware/VTK

- https://gitlab.kitware.com/vtk/vtk-examples

### VTK build with qt
- https://github.com/Kitware/VTK/blob/master/Documentation/docs/build_instructions/build.md
```shell
#生成项目
cmake -S D:/ct/VTK -B D:/ct/VTK/build-qt ^
 -G "Visual Studio 17 2022" -A x64 -T v143 ^
 -DVTK_BUILD_TESTING=OFF -DVTK_BUILD_EXAMPLES=OFF ^
 -DVTK_GROUP_ENABLE_Qt=YES ^
 -DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES ^
 -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES ^
 -DCMAKE_PREFIX_PATH="D:/Software/Qt5.15/5.15.2/msvc2019_64/lib/cmake"

-DVTK_BUILD_TESTING=OFF -DVTK_BUILD_EXAMPLES=OFF -DVTK_GROUP_ENABLE_Qt=YES -DVTK_MODULE_ENABLE_VTK_GUISupportQt=YES -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES -DCMAKE_PREFIX_PATH="D:/Software/Qt5.15/5.15.2/msvc2019_64/lib/cmake"

#编译并安装 Debug
cmake --build D:/ct/VTK/build-qt --config Debug --target ALL_BUILD

cmake --install D:/ct/VTK/build-qt --config Debug --prefix D:/ct/VTK/install-qt


certutil -hashfile v2.7.0.tar.gz SHA512
```


### vtk
```shell
-DVTK_BUILD_EXAMPLES=ON -DVTK_GROUP_ENABLE_qt=ON -DVTK_MODULE_ENABLE_VTK_GUISupportQt=WANT -DVTK_MODULE_ENABLE_VTK_RenderingQt=WANT -DVTK_MODULE_ENABLE_VTK_ViewsQt=WANT -DVTK_QT_VERSION=5 -DVTK_USE_QT=ON -DVTK_QT_VERSION_MAJOR=5 -DVTK_QT_VERSION_MINOR=12
```
