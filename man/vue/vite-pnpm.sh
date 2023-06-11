npm install -g vite

# https://cn.vitejs.dev/guide/
pnpm create vite # 然后按照提示操作即可！
#or
pnpm create vite my-project --template vue-ts
npm create vite@latest my-project -- --template vue-ts
cd my-project
npm install pinia vue-router

# 多页面应用模式
# https://cn.vitejs.dev/guide/build.html#multi-page-app


# vite 开始
# https://cn.vitejs.dev/guide/cli.html
vite [root]
# 选项
  #--host [host]	指定主机名称 (string)
  #--port <port>	指定端口 (number)
  #--https	使用 TLS + HTTP/2 (boolean)
  #--open [path]	启动时打开浏览器 (boolean | string)
  #--cors	启用 CORS (boolean)
  #--strictPort	如果指定的端口已在使用中，则退出 (boolean)
  #--force	强制优化器忽略缓存并重新构建 (boolean)
  #-c, --config <file>	使用指定的配置文件 (string)
  #--base <path>	公共基础路径（默认为：/）(string)
  #-l, --logLevel <level>	Info | warn | error | silent (string)
  #--clearScreen	允许或禁用打印日志时清除屏幕 (boolean)
  #-d, --debug [feat]	显示调试日志 (string | boolean)
  #-f, --filter <filter>	过滤调试日志 (string)
  #-m, --mode <mode>	设置环境模式 (string)
  #-h, --help	显示可用的 CLI 选项
  #-v, --version	显示版本号


vite build [root] ## 构建生产版本。
# 选项
  #--target <target>	编译目标（默认为："modules"）(string)
  #--outDir <dir>	输出目录（默认为：dist）(string)
  #--assetsDir <dir>	在输出目录下放置资源的目录（默认为："assets"）(string)
  #--assetsInlineLimit <number>	静态资源内联为 base64 编码的阈值，以字节为单位（默认为：4096）(number)
  #--ssr [entry]	为服务端渲染配置指定入口文件 (string)
  #--sourcemap [output]	构建后输出 source map 文件（默认为：false）(boolean | "inline" | "hidden")
  #--minify [minifier]	允许或禁用最小化混淆，或指定使用哪种混淆器（默认为："esbuild"）(boolean | "terser" | "esbuild")
  #--manifest [name]	构建后生成 manifest.json 文件 (boolean | string)
  #--ssrManifest [name]	构建后生成 SSR manifest.json 文件 (boolean | string)
  #--force	强制优化器忽略缓存并重新构建（实验性）(boolean)
  #--emptyOutDir	若输出目录在根目录外，强制清空输出目录 (boolean)
  #-w, --watch	在磁盘中模块发生变化时，重新构建 (boolean)
  #-c, --config <file>	使用指定的配置文件 (string)
  #--base <path>	公共基础路径（默认为：/）(string)
  #-l, --logLevel <level>	Info | warn | error | silent (string)
  #--clearScreen	允许或禁用打印日志时清除屏幕 (boolean)
  #-d, --debug [feat]	显示调试日志 (string | boolean)
  #-f, --filter <filter>	过滤调试日志 (string)
  #-m, --mode <mode>	设置环境模式 (string)
  #-h, --help	显示可用的 CLI 选项


vite optimize [root] ## 预构建依赖。
# 选项
  #--force	强制优化器忽略缓存并重新构建 (boolean)
  #-c, --config <file>	使用指定的配置文件 (string)
  #--base <path>	公共基础路径（默认为：/）(string)
  #-l, --logLevel <level>	Info | warn | error | silent (string)
  #--clearScreen	允许或禁用打印日志时清除屏幕 (boolean)
  #-d, --debug [feat]	显示调试日志 (string | boolean)
  #-f, --filter <filter>	过滤调试日志 (string)
  #-m, --mode <mode>	设置环境模式 (string)
  #-h, --help	显示可用的 CLI 选项


vite preview [root] ## 本地预览构建产物。不要将其用作生产服务器，因为它不是为此而设计的。
# 选项
  #--host [host]	指定主机名称 (string)
  #--port <port>	指定端口 (number)
  #--strictPort	如果指定的端口已在使用中，则退出 (boolean)
  #--https	使用 TLS + HTTP/2 (boolean)
  #--open [path]	启动时打开浏览器 (boolean | string)
  #--outDir <dir>	输出目录（默认为：dist)(string)
  #-c, --config <file>	使用指定的配置文件 (string)
  #--base <path>	公共基础路径（默认为：/）(string)
  #-l, --logLevel <level>	Info | warn | error | silent (string)
  #--clearScreen	允许或禁用打印日志时清除屏幕 (boolean)
  #-d, --debug [feat]	显示调试日志 (string | boolean)
  #-f, --filter <filter>	过滤调试日志 (string)
  #-m, --mode <mode>	设置环境模式 (string)
  #-h, --help	显示可用的 CLI 选项


pnpm [command] [flags]
pnpm [ -h | --help | -v | --version ]
  #
  #Manage your dependencies:
  #      add                  Installs a package and any packages that it depends on. By default, any new package is installed as a prod
  #                           dependency
  #      import               Generates a pnpm-lock.yaml from an npm package-lock.json (or npm-shrinkwrap.json) file
  #   i, install              Install all dependencies for a project
  #  it, install-test         Runs a pnpm install followed immediately by a pnpm test
  #  ln, link                 Connect the local project to another one
  #      prune                Removes extraneous packages
  #  rb, rebuild              Rebuild a package
  #  rm, remove               Removes packages from node_modules and from the project's package.json
  #      unlink               Unlinks a package. Like yarn unlink but pnpm re-installs the dependency after removing the external link
  #  up, update               Updates packages to their latest version based on the specified range
  #
  #Review your dependencies:
  #      audit                Checks for known security issues with the installed packages
  #      licenses             Check licenses in consumed packages
  #  ls, list                 Print all the versions of packages that are installed, as well as their dependencies, in a tree-structure
  #      outdated             Check for outdated packages
  #
  #Run your scripts:
  #      exec                 Executes a shell command in scope of a project
  #      run                  Runs a defined package script
  #      start                Runs an arbitrary command specified in the package's "start" property of its "scripts" object
  #   t, test                 Runs a package's "test" script, if one was provided
  #
  #Other:
  #      pack
  #      publish              Publishes a package to the registry
  #      root
  #
  #Manage your store:
  #      store add            Adds new packages to the pnpm store directly. Does not modify any projects or files outside the store
  #      store path           Prints the path to the active store directory
  #      store prune          Removes unreferenced (extraneous, orphan) packages from the store
  #      store status         Checks for modified packages in the store
  #
  #Options:
  #  -r, --recursive          Run the command for each project in the workspace.