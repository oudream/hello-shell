#!/usr/bin/env bash


# 进入canal目录， 执行
mvn clean install -Dmaven.test.skip -Denv=release
#　编译完成后，会在target下面生成一个 canal.deploy-xxx.tar.gz 的文件，用tar 解压就能用

mvn [plugin-name]:[goal-name]
  -D # 指定参数，如 -Dmaven.test.skip=true 跳过单元测试；
  -P # 指定 Profile 配置，可以用于区分环境；
  -e # 显示maven运行出错的信息；
  -o # 离线执行命令,即不去远程仓库更新包；
  -X # 显示maven允许的debug信息；
  -U # 强制去远程更新snapshot的插件或依赖，默认每天只更新一次。

# 创建maven项目：
mvn archetype:create
# 指定 group： -DgroupId=packageName
# 指定 artifact：-DartifactId=projectName
# 创建web项目：-DarchetypeArtifactId=maven-archetype-webapp
# 创建maven项目：
mvn archetype:generate
# 验证项目是否正确：
mvn validate
# maven 打包：
mvn package
# 只打jar包：
mvn jar:jar
# 生成源码jar包：
mvn source:jar
# 产生应用需要的任何额外的源代码：
mvn generate-sources
# 编译源代码：
mvn compile
# 编译测试代码：
mvn test-compile
# 运行测试：
mvn test
# 运行检查：
mvn verify
# 清理maven项目：
mvn clean
# 生成eclipse项目：
mvn eclipse:eclipse
# 清理eclipse配置：
mvn eclipse:clean
# 生成idea项目：
mvn idea:idea
# 安装项目到本地仓库：
mvn install
# 发布项目到远程仓库：
mvn deploy
# 在集成测试可以运行的环境中处理和发布包：
mvn integration-test
# 显示maven依赖树：
mvn dependency:tree
# 显示maven依赖列表：
mvn dependency:list
# 下载依赖包的源码：
mvn dependency:sources
# 安装本地jar到本地仓库：
mvn install:install-file -DgroupId=packageName -DartifactId=projectName -Dversion=version -Dpackaging=jar -Dfile=path


# 启动tomcat：
mvn tomcat:run
# 启动jetty：
mvn jetty:run
# 运行打包部署：
mvn tomcat:deploy
# 撤销部署：
mvn tomcat:undeploy
# 启动web应用：
mvn tomcat:start
# 停止web应用：
mvn tomcat:stop
# 重新部署：
mvn tomcat:redeploy
# 部署展开的war文件：
mvn war:exploded tomcat:exploded


# maven打印依赖树到文件中
mvn dependency:tree >> tree.txt


# 通过在终端中键入以下命令来安装Maven：
sudo yum install maven

# 验证安装通过键入mvn -version命令：
mvn -version
