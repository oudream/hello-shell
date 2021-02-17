#!/usr/bin/env bash


# https://maven.apache.org/guides/getting-started/index.html

# https://maven.apache.org/
# https://maven.apache.org/download.cgi


# 清理所有生成的class和jar；
mvn clean
# 先清理，再执行到compile；
mvn clean compile
# 先清理，再执行到test，因为执行test前必须执行compile，所以这里不必指定compile；
mvn clean test
# 先清理，再执行到package。
mvn clean package
# 單獨編譯模塊
mvn clean package -pl admin -am

mvn tomcat:run


mvn archetype:generate \
  -DarchetypeGroupId=org.apache.maven.archetype \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4 \
  -DgroupId=hello.maven.simple1  \
  -DartifactId=hello1


mvn archetype:generate ^
  -DarchetypeArtifactId=maven-archetype-quickstart ^
  -DarchetypeVersion=1.4 ^
  -DgroupId=hello.maven.hello1  ^
  -DartifactId=hello1

mvn archetype:generate ^
  -DarchetypeArtifactId=maven-archetype-quickstart ^
  -DarchetypeVersion=1.4 ^
  -DgroupId=hello.maven.hello11  ^
  -DartifactId=hello11

mvn archetype:generate ^
  -DarchetypeArtifactId=maven-archetype-quickstart ^
  -DarchetypeVersion=1.4 ^
  -DgroupId=hello.maven.hello12 ^
  -DartifactId=hello12


# brief
# https://www.liaoxuefeng.com/wiki/1252599548343744/1255945359327200


# Maven 1000+ 模板
# https://maven.apache.org/guides/mini/guide-creating-archetypes.html
# https://mvnrepository.com/open-source/maven-archetypes
mvn archetype:generate > templates.txt # waiting few seconds,then exits
mvn archetype:generate # 选择模板


mvn archetype:generate                                  \
  -DarchetypeGroupId=<archetype-groupId>                \
  -DarchetypeArtifactId=<archetype-artifactId>          \
  -DarchetypeVersion=<archetype-version>                \
  -DgroupId=<my.groupid>                                \
  -DartifactId=<my-artifactId>

### mvn archetype:generate
## spring mvc
# https://mvnrepository.com/artifact/co.ntier/spring-mvc-archetype/1.0.2
mvn archetype:generate -DarchetypeGroupId=co.ntier -DarchetypeArtifactId=spring-mvc-archetype -DarchetypeVersion=1.0.2
# https://mvnrepository.com/artifact/org.fluttercode.knappsack/spring-mvc-jpa-archetype/1.1
mvn archetype:generate -DarchetypeGroupId=org.fluttercode.knappsack -DarchetypeArtifactId=spring-mvc-jpa-archetype -DarchetypeVersion=1.1

## hello world
# https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html
mvn --version
# Creating a Project
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
cd my-app
# The src/main/java directory contains the project source code, the src/test/java directory contains the test source, and the pom.xml file is the project's Project Object Model, or POM.
cat >> pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1.0-SNAPSHOT</version>

  <properties>
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
EOF
mvn package
java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App
mvn clean dependency:copy-dependencies package
# Generating the Site
mvn site


# install on windows
# 添 加 MAVEN_HOME 环 境 变 量 ， 值 为 MAVEN 的 解 压 缩 目 录 。 把 MAVEN 的 bin 目 录
# （%MAVEN_HOME%\bin）加入系统的 Path 环境变量
MAVEN_HOME=D:\tools\maven-3
# 运行命令提示符（cmd），输入 mvn -v 并回车测试 Maven 是否安装成功，

cd $MAVEN_HOME
cat >> conf/settings.conf <<EOF
  <mirrors>
    <mirror>
      <id>nexus-aliyun</id>
      <mirrorOf>central</mirrorOf>
      <name>Nexus aliyun</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    </mirror>
  </mirrors>
EOF


### vars
### https://blog.csdn.net/fly910905/article/details/79119349
## 内置属性
# ${basedir} 表示项目根目录，即包含pom.xml文件的目录
# ${version} 等同于 ${project.version} 或者 ${pom.version} 表示项目版本
# ${project.build.sourceDirectory}:项目的主源码目录，默认为src/main/java/.
## 所有pom中的元素都可以用 project.
## 例如${project.artifactId}对应了<project><artifactId>元素的值
## 常用的POM属性包括
# ${project.build.testSourceDirectory}:项目的测试源码目录，默认为/src/test/java/.
# ${project.build.directory}:项目构建输出目录，默认为target/.
# ${project.build.outputDirectory}:项目主代码编译输出目录，默认为target/classes/.
# ${project.build.testOutputDirectory}:项目测试代码编译输出目录，默认为target/testclasses/.
# ${project.groupId}:项目的groupId.
# ${project.artifactId}:项目的artifactId.
# ${project.version}:项目的version,等同于${version}
# ${project.build.finalName}:项目打包输出文件的名称，默认为${project.artifactId}${project.version}.
## 在pom中<properties>元素下自定义的Maven属性
## 所有用的的 settings.xml 中的设定都可以通过 settings. 前缀进行引用
# 与POM属性同理。如${settings.localRepository}指向用户本地仓库的地址
## Java系统属性
## 所有Java系统属性都可以使用Maven属性引用，例如${user.home}指向了用户目录。
## 可以通过命令行mvn help:system查看所有的Java系统属性
### 环境变量属性
## 所有环境变量都可以使用以env.开头的Maven属性引用。
## 例如${env.JAVA_HOME}指代了JAVA_HOME环境变量的值。
## 也可以通过命令行mvn help:system查看所有环境变量。
# ${env.M2_HOME } returns the Maven2 installation path. 代表Maven2的安装路径
# ${java.home } specifies the path to the current JRE_HOME environment use with relative paths to get for example:
# <jvm>${java.home}../bin/java.exe</jvm>
## 父级工程属性
# 上级工程的pom中的变量用前缀 ${project.parent } 引用.
# 上级工程的版本也可以这样引用: ${parent.version }.maven的变量
