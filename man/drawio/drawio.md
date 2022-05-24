

### index.html
- https://github.com/jgraph/drawio/blob/dev/src/main/webapp/index.html


### mxgraph
- https://github.com/maxGraph/maxGraph
- https://jgraph.github.io/mxgraph/
- https://github.com/jgraph/mxgraph
- https://jgraph.github.io/mxgraph/docs/js-api/files/index-txt.html
- 例子中文翻译
- https://github.com/SunInfoFE/mxGraph_User_Manual_CN/blob/master/Examples%E4%BE%8B%E5%AD%90%E4%B8%AD%E6%96%87%E7%BF%BB%E8%AF%91.md

### start drawio
- https://github.com/jgraph/drawio-desktop
- https://github.com/jgraph/drawio
```shell
git clone --recursive https://github.com/jgraph/drawio-desktop.git

npm config set registry http://registry.npm.taobao.org
npm i -g yarn
cd drawio-desktop
npm i
npm run release-win32
```

### start drawio@gitee
- https://gitee.com/oudream/drawio-desktop
- https://gitee.com/oudream/drawio
```shell
git clone https://gitee.com/oudream/drawio-desktop.git
git checkout i3svg-dev
git submodule update --init --recursive

npm config set registry http://registry.npm.taobao.org
npm i -g yarn
cd drawio-desktop
npm i
npm run release-win
```

### windows electron cache
- https://github.com/electron/electron/releases/download/v18.2.0/electron-v18.2.0-win32-x64.zip
```shell
C:\Users\Administrator\AppData\Local\electron\Cache\electron-v18.2.0-win32-x64.zip
```

### linux electron cache
-
```shell
/opt/odan/drawio-desktop/node_modules/electron/dist
```