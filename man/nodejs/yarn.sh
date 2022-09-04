#!/usr/bin/env bash

npm install -g yarn

#    Yarn和npm命令对比
#    npm install === yarn
#    npm install taco --save === yarn add taco
#    npm uninstall taco --save === yarn remove taco
#    npm install taco --save-dev === yarn add taco --dev
#    npm update --save === yarn upgrade


--mode production --env production
--display-reasons --display-used-exports --display-provided-exports
--display-chunks --no-color --display-max-modules 99999
--display-origins --display-entrypoints --output-public-path "dist/" ./example.js -o dist/output.js

--mode production --env production --display-reasons --display-used-exports --display-provided-exports --display-chunks --no-color --display-max-modules 99999 --display-origins --display-entrypoints --output-public-path "dist/" ./example.js -o dist/output.js

# https://classic.yarnpkg.com/en/docs/cli/config
# yarn config set <key> <value> [-g|--global]

yarn --registry=https://registry.npmmirror.com --disturl=https://npmmirror.com/mirrors/node --cache=c:/tmp/_cnpm install
yarn --registry=https://registry.npmmirror.com --disturl=https://npmmirror.com/mirrors/node --cache=/opt/tmp/_cnpm install

npm config set proxy http://192.168.91.138:7890 -g
npm config set https-proxy https://192.168.91.138:7890 -g
yarn config set proxy http://192.168.91.138:7890 -g
yarn config set https-proxy https://192.168.91.138:7890 -g

npm config delete proxy -g
npm config delete https-proxy -g
npm config delete registry -g
npm config delete disturl -g
yarn config delete proxy -g
yarn config delete https-proxy -g
yarn config delete registry -g
yarn config delete disturl -g

git clone https://github.com/daniel-cintra/vue-menu.git
git clone https://github.com/yanjao/vue-simple-template.git