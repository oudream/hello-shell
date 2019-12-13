#!/usr/bin/env bash

# Tutorial, Guides
https://gradle.org/guides/
https://docs.gradle.org/current/userguide/command_line_interface.html
https://docs.gradle.org/current/dsl/index.html

~/.gradle/wrapper/dists # gradle bin
~/.gradle/caches/modules-2/files-2.1 # jar包位置


# 查看依赖图表
gradle dependencies


# 只构建api/rest工程
gradle api:rest:build


# -x选项去排除一个任务
gradle clean build -x test


# 分析构建任务
gradle --profile build


# 查看Gradle任务
gradle tasks
gradle tasks --all


# 用离线模式运行
gradle build --offline

# 用Gradle守护进程进行构建
gradle build --daemon

gradle build --scan # (构建审视) 是Gradle 提供的一个分析构建的工具
#Publishing build scan...
#https://scans.gradle.com/s/kppatiy3qw32g

gradle build --dry-run # 不执行build,只是列出将要执行的任务

# doFirst和doLast生命周期方法来自定义任何Gradle任务
#    apply plugin:'java'
#    test.doFirst {
#        println("running tests...")x`
#    }
#    test.doLast {
#        println("done executing tests...")
#    }

# 刷新Gradle依赖缓存
gradle clean build --refresh-dependencies
# 你也可以手动删除 ~/.gradle/caches



# war name
# if you want to configure the war artefact, you will need to configure the bootWar task instead of base war task :
# https://stackoverflow.com/questions/54501697/gradle-war-plugin-how-to-change-name-of-an-archive
#//addition this in
#bootWar {
#    baseName = 'service'
#    archiveName 'service.war'
#}


# install
brew install gradle

# Gradle从Ant中获取了灵活的特性，从Maven得到了配置，依赖关系管理和插件的基本规范。
# Gradle和Ant一样，将任务作为一等公民对待。

# Gradle构建有三个不同的阶段 - 初始化，配置和执行。
# 初始化阶段用来确定所有将参与构建过程的项目，并为每个项目创建一个Project实例。
# 配置阶段，它会执行所有参与构建过程的项目的构建脚本。
# 执行阶段，所有在配置阶段配置好的任务都会被执行。

# wrapper
# Gradle的wrapper将自己包含在项目中，独立于构建工具的安装。
# 它允许您以零配置方式用Gradle构建项目(无需先安装Gradle distribution)。 这将确保每个人都使用相同版本的构建工具。
#

gradle wrapper --gradle-version 2.14.1
# 这将在你的工程里生成文件:
# gradlew
# gradlew.bat
# gradle/wrapper/gradle-wrapper.jar
# gradle/wrapper/gradle-wrapper.properties

gradle wrapper --gradle-version 3.0-milestone-2
# 升级Gradle版本只是重新生成Gradle wrapper


# https://github.com/gradle/gradle-completion
# macos
brew install gradle-completion
# or
mkdir $HOME/bash_completion.d
curl -LA gradle-completion https://edub.me/gradle-completion-bash -o $HOME/bash_completion.d/gradle-completion.bash
# Add the following to your .bash_profile (macOS) or .bashrc (Linux) file:
source $HOME/bash_completion.d/gradle-completion.bash



# gradlew是gradle wrapper的缩写，也就是说它对gradle的命令进行了包装，
# 比如我们进入到指定Module目录并执行“gradlew.bat assemble”即可完成对当前Module的构建（Windows系统下）。
gradlew [task...] [option...]
gradlew [option...] [task...]
# 其中：option表示选项，task表示任务。
gradlew -?/-h/--help    # 显示帮助信息，即会打印可选参数及参数说明信息；
gradlew -v/--version    # 版本号（会打印工程用的Gradle的版本号、Kotlin、Groovy、Ant、JVM、OS等的版本号）；
gradlew tasks --all     # 查看所有任务，包括缓存任务等；
gradlew clean           # 清除工程目录下的build文件夹；
gradlew build           #  检查依赖并编译打包，debug、release环境的包都会打出来；
gradlew assemble***     # 编译指定的包    # 如Debug包（gradlew assembleDebug）、Release包（gradlew assembleRelease）、渠道包（gradlew assembleOemRelease/assembleOemDebug）、定制的版本等等；
gradlew install***      # 编译并安装指定的包    # 如Debug包（gradlew installDebug）、Release包（gradlew installOemRelease/installOemDebug）、定制的版本等等；
gradlew uninstall**     # 卸载已安装的指定模式的包    # 如Debug包（gradlew uninstallDebug）、Release包（gradlew uninstallRelease）、渠道包（gradlew uninstallOemRelease/uninstallOemDebug）、定制的版本等等；
gradlew :module-name:dependencies # gradlew :app:dependencies # 查看包依赖关系；
gradlew build -i/--info -d/--debug -s/--stacktrace    # 编译(build)并打印debug模式和info等级的日志及所用异常的堆栈信息(--stacktrace)；
gradlew clean build --refresh-dependencies    # 组合指令，清除构建(gradlew clean)并重新构建(gradlew build)，同时强制刷新依赖(gradlew --refresh-dependencies)；
gradlew --offline       # 离线模式，即让Gradle只使用本地cache里的依赖，如果cache中没有也不会更新依赖，而是提示编译失败；
gradlew --refresh-dependencies    # 强制刷新依赖，即检查依赖是否有更新比如动态版本、SHA1进行本地cache和远程仓库散列码的对比等，有更新则下载更新进行构建；使用这种方式可以避免手动删除cache；
--info    # 打印堆栈信息；
gradlew --daemon        # 守护进程，使用Gradle的守护进程构建，能够提高构建效率，如果守护进程没启动或现有的都处于忙碌状态，就启动一个守护进程；
gradlew --no-daemon     # 如果你已经配置为使用守护进程构建，可以使用该选项本次不用守护进程构建；
gradlew --continuous    # 连续构建，即任务队列中即使某个任务失败，不会终止执行，而是会继续执行下一个任务；
gradlew --parallel --parallel-threads=N    # 并行编译；
gradlew --configure-on-demand    # 按需编译。




### hello world --- begin :
# https://guides.gradle.org/creating-new-gradle-builds/
mkdir basic-demo && cd basic-demo
gradle init
#├── build.gradle
#├── gradle
#│   └── wrapper
#│       ├── gradle-wrapper.jar
#│       └── gradle-wrapper.properties
#├── gradlew
#├── gradlew.bat
#└── settings.gradle

# task copy
cat >> build.gradle <<EOF
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory") {
    from "src"
    into "dest"
}
EOF

./gradlew copy


# task zip
cat >> build.gradle <<EOF
plugins {
    id "base"
}
task zip(type: Zip, group: "Archive", description: "Archives sources in a zip file") {
    from "src"
    setArchiveName "basic-demo-1.0.zip"
}
EOF

./gradlew zip

./gradlew tasks

# The properties command tells you about a project’s attributes.
./gradlew properties

### hello world --- end.
