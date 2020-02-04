#!/usr/bin/env bash

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

webpack