#!/usr/bin/env bash


open https://www.chaijs.com/
open https://mochajs.org/
open https://mochajs.org/#command-line-usage


npm install --global mocha

npm install --save chai
npm install --save-dev chai

npm install --save-dev mochawesome

mocha './**/*.@(js|jsx)'
mocha './test/**/*.@(js|jsx)'
mocha ./test.js
mocha ./test1.js ./test2.js
