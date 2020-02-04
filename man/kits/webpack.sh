#!/usr/bin/env bash


webpack js1.js js2.js -o bundle.js


# doc
open https://webpack.docschina.org/concepts/
open https://webpack.js.org/api/cli/
open https://webpack.js.org/guides/getting-started/
# loader
open https://webpack.docschina.org/loaders/
open https://webpack.docschina.org/contribute/writing-a-loader/
# plugin
open https://webpack.docschina.org/plugins/
open https://webpack.docschina.org/contribute/writing-a-plugin/
# awesome
open https://github.com/webpack-contrib/awesome-webpack
# github
https://github.com/webpack/webpack
https://github.com/webpack/webpack-cli

### install
npm i webpack webpack-cli -g

webpack-cli init - Create a new webpack configuration.
webpack-cli info - Returns information related to the local environment.
webpack-cli migrate - Migrate project from one version to another.
webpack-cli generate-plugin - Initiate new plugin project.
webpack-cli generate-loader - Initiate new loader project.
webpack-cli serve - Use webpack with a development server that provides live reloading.

# 你需要全域安装来使用 webpack 大部分的功能：
npm install -g webpack
# 然而 webpack 有些功能，像是优化的 plugins，需要你将它安装在本机。像这种情况下你需要：
npm install --save-dev webpack
# 如果你想要 webpack 在你每次变更储存文件后自动执行 build ：
webpack --watch
# 如果你想要使用自订的 webpack 配置：
webpack --config myconfig.js


### webpack vs webpack-cli
https://stackoverflow.com/questions/51948057/install-webpack-vs-install-webpack-cli
# Since webpack version 4, the command line interface got removed from the main package
#   and added to its own repo and package.
# You are obliged to install a cli aside of webpack. CLI = command line interface,
# webpack = main functionalities.


browserify main.js > bundle.js
# be equivalent to
webpack main.js -o bundle.js


### plugin
https://webpack.docschina.org/contribute/writing-a-plugin/
https://webpack.docschina.org/contribute/writing-a-loader/
## loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个
## 插件并不直接操作单个文件，它直接对整个构建过程其作用。



webpack --help
# webpack-cli 3.3.10

#    Usage: webpack-cli [options]
#           webpack-cli [options] --entry <entry> --output <output>
#           webpack-cli [options] <entries...> --output <output>
#           webpack-cli <command> [options]

# For more information, see https://webpack.js.org/api/cli/.

# Config options:
  --config               # Path to the config file
                         #  [字符串] [默认值: webpack.config.js or webpackfile.js]
  --config-register, -r  # Preload one or more modules before loading the webpack
                         # configuration        [数组] [默认值: module id or path]
  --config-name          # Name of the config to use                      [字符串]
  --env                  # Environment passed to the config, when it is a function
  --mode                 # Enable production optimizations or development hints.
                         #           [可选值: "development", "production", "none"]

# Basic options:
  --context    # The base directory (absolute path!) for resolving the `entry`
               # option. If `output.pathinfo` is set, the included pathinfo is
               # shortened to this directory.
               #                          [字符串] [默认值: The current directory]
  --entry      # The entry point(s) of the compilation.                   [字符串]
  --no-cache   # Disables cached builds                                     [布尔]
  --watch, -w  # Enter watch mode, which rebuilds on file change.           [布尔]
  --debug      # Switch loaders to debug mode                               [布尔]
  --devtool    # A developer tool to enhance debugging.                   [字符串]
  -d           # shortcut for --debug --devtool eval-cheap-module-source-map
               # --output-pathinfo                                          [布尔]
  -p           # shortcut for --optimize-minimize --define
               # process.env.NODE_ENV="production"                          [布尔]
  --progress   # Print compilation progress in percentage                   [布尔]

# Module options:
  --module-bind       # Bind an extension to a loader                     [字符串]
  --module-bind-post  # Bind an extension to a post loader                [字符串]
  --module-bind-pre   # Bind an extension to a pre loader                 [字符串]

# Output options:
  --output, -o                  # The output path and file for compilation assets
  --output-path                 # The output directory as **absolute path**
                                # (required).
                                #         [字符串] [默认值: The current directory]
  --output-filename             # Specifies the name of each output file on disk.
                                # You must **not** specify an absolute path here!
                                # The `output.path` option determines the location
                                # on disk the files are written to, filename is
                                # used solely for naming the individual files.
                                #                     [字符串] [默认值: [name].js]
  --output-chunk-filename       # The filename of non-entry chunks as relative
                                # path inside the `output.path` directory.
        # [字符串] [默认值: filename with [id] instead of [name] or [id] prefixed]
  --output-source-map-filename  # The filename of the SourceMaps for the
                                # JavaScript files. They are inside the
                                # `output.path` directory.                [字符串]
  --output-public-path          # The `publicPath` specifies the public URL
                                # address of the output files when referenced in a
                                # browser.                                [字符串]
  --output-jsonp-function       # The JSONP function used by webpack for async
                                # loading of chunks.                      [字符串]
  --output-pathinfo             # Include comments with information about the
                                # modules.                                  [布尔]
  --output-library              # Expose the exports of the entry point as library
                                #                                           [数组]
  --output-library-target       # Type of library
        # [字符串] [可选值: "var", "assign", "this", "window", "self", "global",
        # "commonjs", "commonjs2", "commonjs-module", "amd", "umd", "umd2", "jsonp"]

# Advanced options:
  --records-input-path       # Store compiler state to a json file.       [字符串]
  --records-output-path      # Load compiler state from a json file.      [字符串]
  --records-path             # Store/Load compiler state from/to a json file. This
                             # will result in persistent ids of modules and
                             # chunks. An absolute path is expected. `recordsPath`
                             # is used for `recordsInputPath` and
                             # `recordsOutputPath` if they left undefined.[字符串]
  --define                   # Define any free var in the bundle          [字符串]
  --target                   # Environment to build for                   [字符串]
  --cache                    # Cache generated modules and chunks to improve
                             # performance for multiple incremental builds.
                             # [布尔] [默认值: It's enabled by default when watching]
  --watch-stdin, --stdin     # Stop watching when stdin stream has ended    [布尔]
  --watch-aggregate-timeout  # Delay the rebuilt after the first change. Value is
                             # a time in ms.                                [数字]
  --watch-poll               # Enable polling mode for watching           [字符串]
  --hot                      # Enables Hot Module Replacement               [布尔]
  --prefetch                 # Prefetch this request (Example: --prefetch
                             # ./file.js)                                 [字符串]
  --provide                  # Provide these modules as free vars in all modules
                             # (Example: --provide jQuery=jquery)         [字符串]
  --labeled-modules          # Enables labeled modules                      [布尔]
  --plugin                   # Load this plugin                           [字符串]
  --bail                     # Report the first error as a hard error instead of
                             # tolerating it.                [布尔] [默认值: null]
  --profile                  # Capture timing information for each module.
                                                           [布尔] [默认值: null]

# Resolving options:
  --resolve-alias         # Redirect module requests                      [字符串]
  --resolve-extensions    # Redirect module requests                        [数组]
  --resolve-loader-alias  # Setup a loader alias for resolving            [字符串]

# Optimizing options:
  --optimize-max-chunks      # Try to keep the chunk count below a limit
  --optimize-min-chunk-size  # Minimal size for the created chunk
  --optimize-minimize        # Enable minimizing the output. Uses
                             # optimization.minimizer.                      [布尔]

# Stats options:
  --color, --colors               # Force colors on the console
                                  #              [布尔] [默认值: (supports-color)]
  --no-color, --no-colors         # Force no colors on the console          [布尔]
  --sort-modules-by               # Sorts the modules list by property in module
                                  #                                       [字符串]
  --sort-chunks-by                # Sorts the chunks list by property in chunk
                                  #                                       [字符串]
  --sort-assets-by                # Sorts the assets list by property in asset
                                  #                                       [字符串]
  --hide-modules                  # Hides info about modules                [布尔]
  --display-exclude               # Exclude modules in the output         [字符串]
  --display-modules               # Display even excluded modules in the output
                                  #                                         [布尔]
  --display-max-modules           # Sets the maximum number of visible modules in
                                  # output                                  [数字]
  --display-chunks                # Display chunks in the output            [布尔]
  --display-entrypoints           # Display entry points in the output      [布尔]
  --display-origins               # Display origins of chunks in the output [布尔]
  --display-cached                # Display also cached modules in the output
                                  #                                         [布尔]
  --display-cached-assets         # Display also cached assets in the output[布尔]
  --display-reasons               # Display reasons about module inclusion in the
                                  # output                                  [布尔]
  --display-depth                 # Display distance from entry point for each
                                  # module                                  [布尔]
  --display-used-exports          # Display information about used exports in
                                  # modules (Tree Shaking)                  [布尔]
  --display-provided-exports      # Display information about exports provided
                                  # from modules                            [布尔]
  --display-optimization-bailout  # Display information about why optimization
                                  # bailed out for modules                  [布尔]
  --display-error-details         # Display details about errors            [布尔]
  --display                       # Select display preset
                                  # [字符串] [可选值: "", "verbose", "detailed", "normal", "minimal",
                                  #                        "errors-only", "none"]
  --verbose                       # Show more details                       [布尔]
  --info-verbosity                # Controls the output of lifecycle messaging
                                  # e.g. Started watching files...
                                  # [字符串] [可选值: "none", "info", "verbose"] [默认值: "info"]
  --build-delimiter               # Display custom text after build output[字符串]

# 选项：
  --help, -h     # 显示帮助信息                                             [布尔]
  --version, -v  # 显示版本号                                               [布尔]
  --silent       # Prevent output from being displayed in stdout            [布尔]
  --json, -j     # Prints the result as JSON.                               [布尔]
