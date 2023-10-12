
###  SEO：搜索引擎爬虫可以直接看到完全渲染的页面。
- Search Engine Optimization，SEO
- https://cn.vuejs.org/guide/scaling-up/ssr.html#why-ssr
```shell
# 创建一个新的文件夹，cd 进入
mkdir hello-ssr
cd hello-ssr

# 执行 npm init -y
npm init -y

# 指定 node 以ES modules mode 运行
# 在 package.json 中添加 "type": "module" 使 Node.js 以 ES modules mode 运行

# 执行 npm install vue
npm install vue

# 创建一个 example.js 文件：

# 接着运行：node example.js
node example.js
```
- example.js
```javascript
// 此文件运行在 Node.js 服务器上
import { createSSRApp } from 'vue'
// Vue 的服务端渲染 API 位于 `vue/server-renderer` 路径下
import { renderToString } from 'vue/server-renderer'

const app = createSSRApp({
  data: () => ({ count: 1 }),
  template: `<button @click="count++">{{ count }}</button>`
})

renderToString(app).then((html) => {
  console.log(html)
})
```
