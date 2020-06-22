#!/usr/bin/env bash



java org.junit.runner.JUnitCore \
    --filter=org.junit.experimental.categories.IncludeCategories=testutils.SlowTests \
    com.example.ExampleTestSuite

java -cp D:\java\lib\junit-4.13.jar;D:\java\lib\hamcrest-core-1.3.jar;D:\tmp\hello11-1.0.1-tests.jar org.junit.runner.JUnitCore hello.maven.hello11.AppTest


### junit
# https://howtodoinjava.com/junit-5-tutorial/
### hamcrest
# http://hamcrest.org/JavaHamcrest/javadoc/2.2/
# http://hamcrest.org/JavaHamcrest/
### maven-jar-plugin
# https://maven.apache.org/plugins/maven-jar-plugin/index.html
### surefire
# https://maven.apache.org/surefire/maven-surefire-plugin/


### jar with test
# maven-jar-plugin	maven 默认打包插件，用来创建 project jar
# maven-shade-plugin	用来打可执行包，executable(fat) jar
# maven-assembly-plugin	支持定制化打包方式，例如 apache 项目的打包方式
# https://www.jianshu.com/p/14bcb17b99e0
# https://maven.apache.org/plugins/maven-jar-plugin/index.html
# https://stackoverflow.com/questions/12828416/generate-test-jar-along-with-jar-file-in-test-package
java -cp D:\java\lib\junit-4.13.jar;D:\java\lib\hamcrest-core-1.3.jar;D:\tmp\hello11-1.0.1-tests.jar org.junit.runner.JUnitCore hello.maven.hello11.AppTest
cat >> pom.xml <<EOF
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-jar-plugin</artifactId>
    <version>2.4</version>
    <executions>
        <execution>
            <goals>
                <goal>test-jar</goal>
            </goals>
        </execution>
    </executions>
</plugin>
EOF


D:\tools\jdk-8\bin\java.exe -Dvisualvm.id=869521750820100 -ea -Didea.test.cyclic.buffer.size=1048576
-javaagent:D:\Software\IntelliJIDEA\lib\idea_rt.jar=52014:D:\Software\IntelliJIDEA\bin
-Dfile.encoding=UTF-8
-classpath
D:\Software\IntelliJIDEA\lib\idea_rt.jar;
D:\Software\IntelliJIDEA\plugins\junit\lib\junit5-rt.jar;
D:\Software\IntelliJIDEA\plugins\junit\lib\junit-rt.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\bin;
D:\tools\jdk-8\jre\lib\charsets.jar;
D:\tools\jdk-8\jre\lib\deploy.jar;
D:\tools\jdk-8\jre\lib\ext\access-bridge-64.jar;
D:\tools\jdk-8\jre\lib\ext\cldrdata.jar;
D:\tools\jdk-8\jre\lib\ext\dnsns.jar;
D:\tools\jdk-8\jre\lib\ext\jaccess.jar;
D:\tools\jdk-8\jre\lib\ext\jfxrt.jar;
D:\tools\jdk-8\jre\lib\ext\localedata.jar;
D:\tools\jdk-8\jre\lib\ext\nashorn.jar;
D:\tools\jdk-8\jre\lib\ext\sunec.jar;
D:\tools\jdk-8\jre\lib\ext\sunjce_provider.jar;
D:\tools\jdk-8\jre\lib\ext\sunmscapi.jar;
D:\tools\jdk-8\jre\lib\ext\sunpkcs11.jar;
D:\tools\jdk-8\jre\lib\ext\zipfs.jar;
D:\tools\jdk-8\jre\lib\javaws.jar;
D:\tools\jdk-8\jre\lib\jce.jar;
D:\tools\jdk-8\jre\lib\jfr.jar;
D:\tools\jdk-8\jre\lib\jfxswt.jar;
D:\tools\jdk-8\jre\lib\jsse.jar;
D:\tools\jdk-8\jre\lib\management-agent.jar;
D:\tools\jdk-8\jre\lib\plugin.jar;
D:\tools\jdk-8\jre\lib\resources.jar;
D:\tools\jdk-8\jre\lib\rt.jar;
D:\Software\IntelliJIDEA\lib\junit-4.12.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\antlr-2.7.7.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\dom4j-1.6.1.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-commons-annotations-4.0.2.Final.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-core-4.2.4.Final.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-jpa-2.0-api-1.0.1.Final.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\javassist-3.15.0-GA.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\jboss-logging-3.1.0.GA.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\jboss-transaction-api_1.1_spec-1.0.1.Final.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\mysql-connector-java-5.1.7-bin.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\c3p0-0.9.2.1.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-c3p0-4.2.4.Final.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\mchange-commons-java-0.2.3.4.jar;
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hamcrest-core-1.3.jar com.intellij.rt.junit.JUnitStarter -ideVersion5 -junit4 com.atguigu.hibernate.helloworld.HibernateTest,test


java -cp ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\antlr-2.7.7.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\dom4j-1.6.1.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-commons-annotations-4.0.2.Final.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-core-4.2.4.Final.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-jpa-2.0-api-1.0.1.Final.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\javassist-3.15.0-GA.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\jboss-logging-3.1.0.GA.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\jboss-transaction-api_1.1_spec-1.0.1.Final.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\mysql-connector-java-5.1.7-bin.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\c3p0-0.9.2.1.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hibernate-c3p0-4.2.4.Final.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\mchange-commons-java-0.2.3.4.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib\hamcrest-core-1.3.jar; ^
D:\java\lib\junit-4.13.jar; ^
D:\hello-spring-hibernate\examples\atguigu\hibernate-1\bin org.junit.runner.JUnitCore


java -cp junit-4.12.jar;hamcrest-core-1.3.jar;. org.junit.runner.JUnitCore UserDAOTest ProductDAOTest
java -cp D:\java\lib\junit-4.13.jar;D:\java\lib\hamcrest-core-1.3.jar;D:\tmp\hello11-1.0.1.jar org.junit.runner.JUnitCore hello.maven.hello11.AppTest
java -cp D:\java\lib\junit-4.13.jar;D:\java\lib\hamcrest-core-1.3.jar;D:\tmp\hello11-1.0.1-tests.jar org.junit.runner.JUnitCore hello.maven.hello11.AppTest


java -cp D:\hello-spring-hibernate\examples\atguigu\hibernate-1\lib;D:\hello-spring-hibernate\examples\atguigu\hibernate-1\bin;D:\java\lib\junit-4.13.jar org.junit.runner.JUnitCore com.atguigu.hibernate.helloworld.HibernateTest


java  -cp D:\workspace\AppiumTest\src\main\target\classes;D:\maven_repository\junit\junit\4.12\junit-4.12.jar;D:\maven_repository\org\hamcrest\hamcrest-core\1.3\hamcrest-core-1.3.jar test.android.JunitRunner


