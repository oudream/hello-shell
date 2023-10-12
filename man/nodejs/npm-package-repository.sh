# lm-vform3
# https://www.npmjs.com/package/lm-vform3?activeTab=code

### 如何发布一个自己的npm包？
# https://juejin.cn/post/6864776736812236808
# 在终端输入以下命令，npm-demo为包的目录，可以自己任意取名
mkdir lm-vform3
cd lm-vform3
# npm init 命令，生成package.json文件（NPM通过提问似的交互，逐个填入选项，最后生成预览的包描述文件，如果ok）
npm init
# npm必须要使用仓库账号才允许将包发布到仓库中。（提问似的交互过程，按顺序进行即可，主要是 username, password)
npm adduser
# 上传包的命令是：npm publish 包文件夹名字。
npm publish . # 开始上传包
## 更新包
# npm包修改后，手动把package.json里的version版本号修改了，或者使用以下命令自动更新版本号，再执行npm publish . 命令就可以了。
npm publish .
