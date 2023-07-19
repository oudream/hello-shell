#!/usr/bin/env bash


https://github.com/swagger-api/swagger-codegen


### install swagger-codegen
## linux
# If you're looking for the latest stable version, you can grab it directly from Maven.org (Java 8 runtime at a minimum):
wget http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.10/swagger-codegen-cli-2.4.10.jar -O swagger-codegen-cli.jar
java -jar swagger-codegen-cli.jar help

## windows
# For Windows users, you will need to install wget or you can use Invoke-WebRequest in PowerShell (3.0+), e.g.
Invoke-WebRequest -OutFile swagger-codegen-cli.jar http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.10/swagger-codegen-cli-2.4.10.jar

## macos
# On a mac, it's even easier with brew:
brew install swagger-codegen
# swagger-codegen
/usr/local/Cellar/swagger-codegen/3.0.14/bin/swagger-codegen
exec java  -jar /usr/local/Cellar/swagger-codegen/3.0.14/libexec/swagger-codegen-cli.jar "$@"

## docker
git clone https://github.com/swagger-api/swagger-codegen
cd swagger-codegen
./run-in-docker.sh mvn package

## source code
git clone https://github.com/swagger-api/swagger-codegen.git --recursive
cd swagger-codegen
mvn clean package

## test
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
   -i http://petstore.swagger.io/v2/swagger.json \
   -l php \
   -o /var/tmp/php_api_client
# or
swagger-codegen generate \
    -i http://petstore.swagger.io/v2/swagger.json \
    -l ruby -o /tmp/test/
swagger-codegen generate \
    -l nodejs-server \
    -i http://petstore.swagger.io/v2/swagger.json --disable-examples
swagger-codegen generate \
    -l java \
    -i http://petstore.swagger.io/v2/swagger.json --disable-examples
swagger-codegen generate \
    -l javascript \
    -i http://petstore.swagger.io/v2/swagger.json --disable-examples


cd /opt/tmp/swagger1/javascript
browserify src/index.js > bundle.js



#    named arguments:
#      -h, --help             show this help message and exit
#
#    commands:
#      Command                additional help
#        generate             generate
#        config-help          config-help
#        meta                 meta
#        langs                langs
#        version              version

# Available languages:
[aspnetcore, csharp, csharp-dotnet2, go-server, dynamic-html, html, html2, java, jaxrs-cxf-client, jaxrs-cxf,
inflector, jaxrs-cxf-cdi, jaxrs-spec, jaxrs-jersey, jaxrs-di, jaxrs-resteasy-eap, jaxrs-resteasy, micronaut, spring,
nodejs-server, openapi, openapi-yaml, kotlin-client, kotlin-server, php, python, python-flask, scala,
scala-akka-http-server, swift3, swift4, typescript-angular, javascript]

#usage: swagger-codegen generate [-h] [-v []] [-l] [-o] [-i] [-t] [--template-version] [--template-engine] [-a] [-c]
#                       [-D [ [ ...]]] [-s] [--api-package] [--model-package] [--model-name-prefix] [--model-name-suffix]
#                       [--instantiation-types [ [ ...]]] [--type-mappings [ [ ...]]] [--additional-properties [ [ ...]]]
#                       [--import-mappings [ [ ...]]] [--invoker-package] [--group-id] [--artifact-id] [--artifact-version]
#                       [--library] [--git-user-id] [--git-repo-id] [--release-note] [--http-user-agent]
#                       [--reserved-words-mappings [ [ ...]]] [--ignore-file-override] [--remove-operation-id-prefix] [-u]
#                       [--disable-examples []]

# named arguments:
  -h, --help             # show this help message and exit
  -v [], --verbose []    # verbose mode
  -l, --lang             # client language to generate (maybe class name in classpath, required)
  -o, --output           # where to write the generated files (current dir by default)
  -i, --input-spec       # location of the swagger spec, as URL or file (required)
  -t, --template-dir     # folder containing the template files
  --template-version     # version of the template used on generation.
  --template-engine      # template engine to generate files, currently supported: 'mustache' and 'handlebars'.
  -a, --auth             # adds authorization headers when fetching  the  swagger  definitions  remotely. Pass in a URL-encoded
                         # string of name:header with a comma separating multiple values
  -c, --config           # Path to  json  configuration  file.   File  content  should  be  in  a  json  format  {"optionKey":"
                         # optionValue", "optionKey1":"optionValue1"...} Supported options can  be different for each language.
                         # Run config-help -l {lang} command for language specific config options.
  -D [ [ ...]]           # sets specified system properties in the  format  of name=value,name=value (or multiple options, each
                         # with name=value)
  -s, --skip-overwrite   # specifies if the existing files should be overwritten during the generation.
  --api-package          # package for generated api classes
  --model-package        # package for generated models
  --model-name-prefix    # Prefix that will be prepended to all model names. Default is the empty string.
  --model-name-suffix    # PrefixSuffix that will be appended to all model names. Default is the empty string.
  --instantiation-types [ [ ...]]
                         # sets instantiation type mappings in  the  format of type=instantiatedType,type=instantiatedType. For
                         # example (in Java): array=ArrayList,map=HashMap. In other words  array types will get instantiated as
                         # ArrayList in generated code. You can also have multiple occurrences of this option.
  --type-mappings [ [ ...]]
                         # sets  mappings  between  swagger  spec   types   and   generated   code   types  in  the  format  of
                         # swaggerType=generatedType,swaggerType=generatedType. For  example: array=List,map=Map,string=String.
                         # You can also have multiple occurrences of this option.
  --additional-properties [ [ ...]]
                         # sets additional properties that  can  be  referenced  by  the  mustache  templates  in the format of
                         # name=value,name=value. You can also have multiple occurrences of this option.
  --import-mappings [ [ ...]]
                         # specifies mappings between a given class and the  import  that  should be used for that class in the
                         # format of type=import,type=import. You can also have multiple occurrences of this option.
  --invoker-package      # root package for generated code
  --group-id             # groupId in generated pom.xml
  --artifact-id          # artifactId in generated pom.xml
  --artifact-version     # artifact version generated in pom.xml
  --library              # library template (sub-template)
  --git-user-id          # Git user ID, e.g. swagger-api.
  --git-repo-id          # Git repo ID, e.g. swagger-codegen.
  --release-note         # Release note, default to 'Minor update'.
  --http-user-agent      # HTTP user  agent,  e.g.  codegen_csharp_api_client,  default  to 'Swagger-Codegen/{packageVersion}}/
                         # {language}'
  --reserved-words-mappings [ [ ...]]
                         # pecifies how a reserved name should  be  escaped  to.  Otherwise,  the  default _<name> is used. For
                         # example id=identifier. You can also have multiple occurrences of this option.
  --ignore-file-override
                         # Specifies an  override  location  for  the  .swagger-codegen-ignore  file.  Most  useful  on initial
                         # generation.
  --remove-operation-id-prefix
                         # Remove prefix of operationId, e.g. config_getId => getId
  -u, --url              # load arguments from a local file  or  remote  URL.  Arguments  found  will replace any one placed on
                         # command.
  --disable-examples []  # avoid writing json/xml examples on generated operations.


# server
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
    -i modules/swagger-codegen/src/test/resources/2_0/petstore.json -l perl \
    --git-user-id "swaggerapi" \
    --git-repo-id "petstore-perl" \
    --release-note "Github integration demo" \
    -o /var/tmp/perl/petstore


# client
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
  -i http://petstore.swagger.io/v2/swagger.json \
  -l java \
  -o samples/client/petstore/java
