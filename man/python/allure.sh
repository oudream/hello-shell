#!/usr/bin/env bash

# doc , allure , allure release , allure-python , allure-pytest
# https://docs.qameta.io/allure/#_commandline
# https://github.com/allure-framework/allure-python
# https://github.com/allure-framework/allure2/releases/
# https://pypi.org/project/allure-pytest/#files

# pytest文档29-allure-pytest(最新最全，保证能搞成功！)
# https://cloud.tencent.com/developer/article/1556151


# allure generate <directory-with-results> -o <directory-with-report>
# allure open <directory-with-report>
allure generate .\report\20200708140305 -o .\report\html
allure open .\report\html


allure [options] [command] [command options]
  Options:
    --help
      Print commandline help.
    -q, --quiet
      Switch on the quiet mode.
      Default: false
    -v, --verbose
      Switch on the verbose mode.
      Default: false
    --version
      Print commandline version.
      Default: false
  Commands:
    generate      Generate the report
      Usage: generate [options] The directories with allure results
        Options:
          -c, --clean
            Clean Allure report directory before generating a new one.
            Default: false
          --config
            Allure commandline config path. If specified overrides values from
            --profile and --configDirectory.
          --configDirectory
            Allure commandline configurations directory. By default uses
            ALLURE_HOME directory.
          --profile
            Allure commandline configuration profile.
          -o, --report-dir, --output
            The directory to generate Allure report into.
            Default: allure-report

    serve      Serve the report
      Usage: serve [options] The directories with allure results
        Options:
          --config
            Allure commandline config path. If specified overrides values from
            --profile and --configDirectory.
          --configDirectory
            Allure commandline configurations directory. By default uses
            ALLURE_HOME directory.
          -h, --host
            This host will be used to start web server for the report.
          -p, --port
            This port will be used to start web server for the report.
            Default: 0
          --profile
            Allure commandline configuration profile.

    open      Open generated report
      Usage: open [options] The report directory
        Options:
          -h, --host
            This host will be used to start web server for the report.
          -p, --port
            This port will be used to start web server for the report.
            Default: 0

    plugin      Generate the report
      Usage: plugin [options]
        Options:
          --config
            Allure commandline config path. If specified overrides values from
            --profile and --configDirectory.
          --configDirectory
            Allure commandline configurations directory. By default uses
            ALLURE_HOME directory.
          --profile
            Allure commandline configuration profile.
