#!/usr/bin/env bash


https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#cli
https://docs.spring.io/spring-boot/docs/2.2.2.RELEASE/gradle-plugin/reference/html/


spring shell # Using the Embedded Shell



spring [--help] [--version]
       <command> [<args>]

spring version

spring help run


# hello world
cat >> /tmp/hello.groovy <<EOF
@RestController
class WebApplication {

    @RequestMapping("/")
    String home() {
        "Hello World!"
    }

}
EOF

spring run /tmp/hello.groovy
spring run /tmp/hello.groovy -- --server.port=9000


# Applications with Multiple Source Files
spring run *.groovy

# Packaging Your Application
spring jar my-app.jar *.groovy
# public/**, resources/**, static/**, templates/**, META-INF/**, *
# .*, repository/**, build/**, target/**, **/*.jar, **/*.groovy


# Initialize a New Project
# start.spring.io
spring init --dependencies=web,data-jpa my-project
#Using service at https://start.spring.io
#Project extracted to '/Users/developer/example/my-project'
spring init --list
spring init --build=gradle --java-version=1.8 --dependencies=websocket --packaging=war sample-app.zip

#  grab
#    Download a spring groovy script's dependencies to ./repository

#  jar [options] <jar-name> <files>
#    Create a self-contained executable jar file from a Spring Groovy script

#  war [options] <war-name> <files>
#    Create a self-contained executable war file from a Spring Groovy script

#  install/uninstall [options] <coordinates>
#    Install dependencies to the lib/ext directory
# group:artifact:version
spring install com.example:spring-boot-cli-extension:1.0.0.RELEASE
spring uninstall com.example:spring-boot-cli-extension:1.0.0.RELEASE
spring uninstall --all

