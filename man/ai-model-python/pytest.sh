#!/usr/bin/env bash


pytest -sm "login or goods"


### example and guide
# https://docs.pytest.org/en/latest/example/index.html
# https://docs.pytest.org/en/stable/example/markers.html
# https://docs.pytest.org/en/stable/mark.html
# 中文
# https://www.osgeo.cn/pytest/index.html

### mark
# https://www.cnblogs.com/Simple-Small/p/11077123.html

### hooks
# https://docs.pytest.org/en/stable/_modules/_pytest/hookspec.html
# https://docs.pytest.org/en/latest/_modules/_pytest/runner.html
# https://www.osgeo.cn/pytest/reference.html#bootstrapping-hooks
# https://www.jianshu.com/p/32b645b61339

# The --markers option always gives you a list of available markers:
pytest --markers

# running all tests except the webtest ones:

pytest -v -m "not webtest"

pytest -m "interface or event" --tb=short

pytest -v test_server.py::TestClass::test_method


# 以下Pytest功能适用于 unittest.TestCase 子类：
#    Marks ： skip ， skipif ， xfail ；
#    Auto-use fixtures ；
# 以下Pytest功能 不 工作，可能永远不会由于不同的设计理念：
#    Fixtures （除 autouse 固定装置，见 below ；
#    Parametrization ；
#    Custom hooks ；
# https://www.osgeo.cn/pytest/unittest.html


### 参数
# -s
# -s 显示 print 内容
# 在运行测试脚本时，为了调试或打印一些内容，我们会在代码中加一些print内容，但是在运行pytest时，这些内容不会显示出来。如果带上-s，就可以显示了。



### 测试插件
# 常用插件
# https://www.jianshu.com/p/2c58b4825ccc
# https://pypi.org/project/pytest-rerunfailures/
# https://pypi.org/project/pytest-dependency/
# https://github.com/RKrahl/pytest-dependency



pytest [options] [file_or_dir] [file_or_dir] [...]

# positional arguments:
  file_or_dir

# general:
  -k EXPRESSION         only run tests which match the given substring expression. An expression is a python evaluatable expression where all names are substring-matched against test names and their parent classes. Example: -k
                        'test_method or test_other' matches all test functions and classes whose name contains 'test_method' or 'test_other', while -k 'not test_method' matches those that don't contain 'test_method' in their names.
                        -k 'not test_method and not test_other' will eliminate the matches. Additionally keywords are matched to classes and functions containing extra names in their 'extra_keyword_matches' set, as well as functions

                        which have names assigned directly to them. The matching is case-insensitive.
  -m MARKEXPR           only run tests matching given mark expression. example: -m 'mark1 and not mark2'.
  --markers             show markers (builtin, plugin and per-project ones).
  -x, --exitfirst       exit instantly on first error or failed test.
  --maxfail=num         exit after first num failures or errors.
  --strict-markers, --strict
                        markers not registered in the `markers` section of the configuration file raise errors.
  -c file               load configuration from `file` instead of trying to locate one of the implicit configuration files.
  --continue-on-collection-errors
                        Force test execution even if collection errors occur.
  --rootdir=ROOTDIR     Define root directory for tests. Can be relative path: 'root_dir', './root_dir', 'root_dir/another_dir/'; absolute path: '/home/user/root_dir'; path with variables: '$HOME/root_dir'.
  --fixtures, --funcargs
                        show available fixtures, sorted by plugin appearance (fixtures with leading '_' are only shown with '-v')
  --fixtures-per-test   show fixtures per test
  --import-mode={prepend,append}
                        prepend/append to sys.path when importing test modules, default is to prepend.
  --pdb                 start the interactive Python debugger on errors or KeyboardInterrupt.
  --pdbcls=modulename:classname
                        start a custom interactive Python debugger on errors. For example: --pdbcls=IPython.terminal.debugger:TerminalPdb
  --trace               Immediately break when running each test.
  --capture=method      per-test capturing method: one of fd|sys|no|tee-sys.
  -s                    shortcut for --capture=no.
  --runxfail            report the results of xfail tests as if they were not marked
  --lf, --last-failed   rerun only the tests that failed at the last run (or all if none failed)
  --ff, --failed-first  run all tests but run the last failures first. This may re-order tests and thus lead to repeated fixture setup/teardown
  --nf, --new-first     run tests from new files first, then the rest of the tests sorted by file mtime
  --cache-show=[CACHESHOW]
                        show cache contents, don't perform collection or tests. Optional argument: glob (default: '*').
  --cache-clear         remove all cache contents at start of test run.
  --lfnf={all,none}, --last-failed-no-failures={all,none}
                        which tests to run with no previously (known) failures.
  --sw, --stepwise      exit on test failure and continue from last failing test next time
  --stepwise-skip       ignore the first failing test but stop on the next failing test

reporting:
  --durations=N         show N slowest setup/test durations (N=0 for all).
  -v, --verbose         increase verbosity.
  -q, --quiet           decrease verbosity.
  --verbosity=VERBOSE   set verbosity. Default is 0.
  -r chars              show extra test summary info as specified by chars: (f)ailed, (E)rror, (s)kipped, (x)failed, (X)passed, (p)assed, (P)assed with output, (a)ll except passed (p/P), or (A)ll. (w)arnings are enabled by default
                        (see --disable-warnings), 'N' can be used to reset the list. (default: 'fE').
  --disable-warnings, --disable-pytest-warnings
                        disable warnings summary
  -l, --showlocals      show locals in tracebacks (disabled by default).
  --tb=style            traceback print mode (auto/long/short/line/native/no).
  --show-capture={no,stdout,stderr,log,all}
                        Controls how captured stdout/stderr/log is shown on failed tests. Default is 'all'.
  --full-trace          don't cut any tracebacks (default is to cut).
  --color=color         color terminal output (yes/no/auto).
  --pastebin=mode       send failed|all info to bpaste.net pastebin service.
  --junit-xml=path      create junit-xml style report file at given path.
  --junit-prefix=str    prepend prefix to classnames in junit-xml output
  --result-log=path     DEPRECATED path for machine-readable result log.

collection:
  --collect-only, --co  only collect tests, don't execute them.
  --pyargs              try to interpret all arguments as python packages.
  --ignore=path         ignore path during collection (multi-allowed).
  --ignore-glob=path    ignore path pattern during collection (multi-allowed).
  --deselect=nodeid_prefix
                        deselect item (via node id prefix) during collection (multi-allowed).
  --confcutdir=dir      only load conftest.py's relative to specified dir.
  --noconftest          Don't load any conftest.py files.
  --keep-duplicates     Keep duplicate tests.
  --collect-in-virtualenv
                        Don't ignore tests in a local virtualenv directory
  --doctest-modules     run doctests in all .py modules
  --doctest-report={none,cdiff,ndiff,udiff,only_first_failure}
                        choose another output format for diffs on doctest failure
  --doctest-glob=pat    doctests file matching pattern, default: test*.txt
  --doctest-ignore-import-errors
                        ignore doctest ImportErrors
  --doctest-continue-on-failure
                        for a given doctest, continue to run after the first failure

test session debugging and configuration:
  --basetemp=dir        base temporary directory for this test run.(warning: this directory is removed if it exists)
  -V, --version         display pytest version and information about plugins.
  -h, --help            show help message and configuration info
  -p name               early-load given plugin module name or entry point (multi-allowed). To avoid loading of plugins, use the `no:` prefix, e.g. `no:doctest`.
  --trace-config        trace considerations of conftest.py files.
  --debug               store internal tracing debug information in 'pytestdebug.log'.
  -o OVERRIDE_INI, --override-ini=OVERRIDE_INI
                        override ini option with "option=value" style, e.g. `-o xfail_strict=True -o cache_dir=cache`.
  --assert=MODE         Control assertion debugging tools. 'plain' performs no assertion debugging. 'rewrite' (the default) rewrites assert statements in test modules on import to provide assert expression information.
  --setup-only          only setup fixtures, do not execute tests.
  --setup-show          show setup of fixtures while executing tests.
  --setup-plan          show what fixtures and tests would be executed but don't execute anything.

pytest-warnings:
  -W PYTHONWARNINGS, --pythonwarnings=PYTHONWARNINGS
                        set which warnings to report, see -W option of python itself.

logging:
  --no-print-logs       disable printing caught logs on failed tests.
  --log-level=LEVEL     level of messages to catch/display. Not set by default, so it depends on the root/parent log handler's effective level, where it is "WARNING" by default.
  --log-format=LOG_FORMAT
                        log format as used by the logging module.
  --log-date-format=LOG_DATE_FORMAT
                        log date format as used by the logging module.
  --log-cli-level=LOG_CLI_LEVEL
                        cli logging level.
  --log-cli-format=LOG_CLI_FORMAT
                        log format as used by the logging module.
  --log-cli-date-format=LOG_CLI_DATE_FORMAT
                        log date format as used by the logging module.
  --log-file=LOG_FILE   path to a file when logging will be written to.
  --log-file-level=LOG_FILE_LEVEL
                        log file logging level.
  --log-file-format=LOG_FILE_FORMAT
                        log format as used by the logging module.
  --log-file-date-format=LOG_FILE_DATE_FORMAT
                        log date format as used by the logging module.
  --log-auto-indent=LOG_AUTO_INDENT
                        Auto-indent multiline messages passed to the logging module. Accepts true|on, false|off or an integer.

[pytest] ini-options in the first pytest.ini|tox.ini|setup.cfg file found:

  markers (linelist):   markers for test functions
  empty_parameter_set_mark (string):
                        default marker for empty parametersets
  norecursedirs (args): directory patterns to avoid for recursion
  testpaths (args):     directories to search for tests when no files or directories are given in the command line.
  usefixtures (args):   list of default fixtures to be used with this project
  python_files (args):  glob-style file patterns for Python test module discovery
  python_classes (args):
                        prefixes or glob names for Python test class discovery
  python_functions (args):
                        prefixes or glob names for Python test function and method discovery
  disable_test_id_escaping_and_forfeit_all_rights_to_community_support (bool):
                        disable string escape non-ascii characters, might cause unwanted side effects(use at your own risk)
  console_output_style (string):
                        console output: "classic", or with additional progress information ("progress" (percentage) | "count").
  xfail_strict (bool):  default for the strict parameter of xfail markers when not given explicitly (default: False)
  enable_assertion_pass_hook (bool):
                        Enables the pytest_assertion_pass hook.Make sure to delete any previously generated pyc cache files.
  junit_suite_name (string):
                        Test suite name for JUnit report
  junit_logging (string):
                        Write captured log messages to JUnit report: one of no|log|system-out|system-err|out-err|all
  junit_log_passing_tests (bool):
                        Capture log information for passing tests to JUnit report:
  junit_duration_report (string):
                        Duration time to report: one of total|call
  junit_family (string):
                        Emit XML for schema: one of legacy|xunit1|xunit2
  doctest_optionflags (args):
                        option flags for doctests
  doctest_encoding (string):
                        encoding used for doctest files
  cache_dir (string):   cache directory path.
  filterwarnings (linelist):
                        Each line specifies a pattern for warnings.filterwarnings. Processed after -W/--pythonwarnings.
  log_print (bool):     default value for --no-print-logs
  log_level (string):   default value for --log-level
  log_format (string):  default value for --log-format
  log_date_format (string):
                        default value for --log-date-format
  log_cli (bool):       enable log display during test run (also known as "live logging").
  log_cli_level (string):
                        default value for --log-cli-level
  log_cli_format (string):
                        default value for --log-cli-format
  log_cli_date_format (string):
                        default value for --log-cli-date-format
  log_file (string):    default value for --log-file
  log_file_level (string):
                        default value for --log-file-level
  log_file_format (string):
                        default value for --log-file-format
  log_file_date_format (string):
                        default value for --log-file-date-format
  log_auto_indent (string):
                        default value for --log-auto-indent
  faulthandler_timeout (string):
                        Dump the traceback of all threads if a test takes more than TIMEOUT seconds to finish. Not available on Windows.
  addopts (args):       extra command line options
  minversion (string):  minimally required pytest version

environment variables:
  PYTEST_ADDOPTS           extra command line options
  PYTEST_PLUGINS           comma-separated plugins to load during startup
  PYTEST_DISABLE_PLUGIN_AUTOLOAD set to disable plugin auto-loading
  PYTEST_DEBUG             set to enable debug tracing of pytest's internals


to see available markers type: pytest --markers
to see available fixtures type: pytest --fixtures
(shown according to specified file_or_dir or current dir if not specified; fixtures with leading '_' are only shown with the '-v' option
