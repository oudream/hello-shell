
### <script setup> 中的顶层的导入、声明的变量和函数可在同一组件的模板中直接使用。
> 你可以理解为模板是在同一作用域内声明的一个 JavaScript 函数——它自然可以访问与它一起声明的所有内容。
- https://cn.vuejs.org/guide/essentials/reactivity-fundamentals.html#script-setup

### TypeScript 与选项式 API
- https://cn.vuejs.org/guide/typescript/options-api.html

### 组合式 API 常见问答
- https://cn.vuejs.org/guide/extras/composition-api-faq.html

### 可以在同一个组件中使用两种 API 吗？ 
> 可以。你可以在一个选项式 API 的组件中通过 setup() 选项来使用组合式 API。  
> 然而，我们只推荐你在一个已经基于选项式 API 开发了很久、但又需要和基于组合式 API 的新代码或是第三方库整合的项目中这样做。
