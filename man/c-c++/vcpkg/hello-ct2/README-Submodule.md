
### 下载代码
```shell
git clone --recurse-submodules <your_repo_url>
# 或者如果已经 clone：
git submodule update --init --recursive
```


### Google 开源项目风格指南——中文版
> https://github.com/zh-google-styleguide/zh-google-styleguide
- C++ 风格指南
> https://zh-google-styleguide.readthedocs.io/en/latest/google-cpp-styleguide/
- Go 语言编码规范中文版 - Uber
> https://github.com/xxjwxc/uber_go_guide_cn


### Git 子模块设置：指定版本拉取并添加到项目中

- 添加 opencv 4.9.0
```shell
# 添加 OpenCV 作为子模块，放在 3rd/opencv
git submodule add https://github.com/opencv/opencv.git 3rd/opencv
cd 3rd/opencv
git checkout 4.12.0    # 切换到你要固定的版本
cd ../../
git add 3rd/opencv
```

- 添加 vtk v9.5.0
```shell
# 添加 VTK 作为子模块，放在 3rd/vtk
git submodule add https://github.com/Kitware/VTK.git 3rd/vtk
cd 3rd/vtk
git checkout e70c856  # 切换到 v9.5.0 的具体 commit
cd ../../
git add 3rd/vtk
```

- 添加 GoogleTest v1.17.0
```bash
git submodule add https://github.com/google/googletest.git 3rd/googletest
cd 3rd/googletest
git checkout v1.17.0
cd ../../
git add 3rd/googletest
```

- 添加 Google Benchmark v1.9.4
```bash
git submodule add https://github.com/google/benchmark.git 3rd/benchmark
cd 3rd/benchmark
git checkout v1.9.4
cd ../../
git add 3rd/benchmark
```

- 添加 ITK v5.4.4
```bash
git submodule add https://github.com/InsightSoftwareConsortium/ITK.git 3rd/itk
cd 3rd/itk
git checkout v5.4.4
cd ../../
git add 3rd/itk
```

- 添加 RTK v2.7.0
```bash
git submodule add https://github.com/RTKConsortium/RTK.git 3rd/rtk
cd 3rd/rtk
git checkout v2.7.0
cd ../../
git add 3rd/rtk
```
