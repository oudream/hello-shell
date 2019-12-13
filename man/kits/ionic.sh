#!/usr/bin/env bash

ionic --help
ionic cordova --help
ionic cordova run --help

ionic generate page xxx

ionic cordova run android -l --address=0.0.0.0 -p 8101

ionic serve --address=0.0.0.0 -p 8101
# --no-livereload
# Do not spin up dev server--just serve files

ionic info
ionic info --json

ionic cordova requirements android
ionic cordova requirements ios

# install
npm install -g ionic cordova



npx # /usr/local/lib/node_modules/npm/bin/npx-cli.js
npx ng g <type> --help
npx ng g page --help
npx ng g component --help
ionic generate
ionic generate page
ionic generate page contact
ionic generate component contact/form
ionic generate component login-form --change-detection=OnPush
ionic generate directive ripple --skip-import
ionic generate service api/user



ionic cordova plugin [<action>] [<plugin>] [options]
# action
# add or remove a plugin; ls or save all project plugins
# --force
# Force overwrite the plugin if it exists (corresponds to add)
ionic cordova plugin
ionic cordova plugin add cordova-plugin-inappbrowser@latest
ionic cordova plugin add phonegap-plugin-push --variable SENDER_ID=XXXXX
ionic cordova plugin rm cordova-plugin-camera



ionic start <name> <template> [options]
# --list
# List available starter templates
# Aliases -l
ionic start
ionic start --list
ionic start myApp
ionic start myApp blank
ionic start myApp tabs --cordova
ionic start myApp tabs --capacitor
ionic start myApp super --type=ionic-angular
ionic start myApp blank --type=ionic1
ionic start cordovaApp tabs --cordova
ionic start "My App" blank
ionic start "Conference App" https://github.com/ionic-team/ionic-conference-app



ionic cordova run [<platform>] [options]
#    --ssl ........................... [ng] (--livereload) (experimental) Use HTTPS for the dev server
#    --list .......................... List all available targets
#    --no-build ...................... Do not invoke Ionic build
#    --external ...................... Host dev server on all network interfaces (i.e. --address=0.0.0.0)
#    --livereload, -l ................ Spin up dev server to live-reload www files
#    --livereload-url=<url> .......... Provide a custom URL to the dev server
#    --prod .......................... [ng] Flag to use the production configuration
#    --debug ......................... [cordova] Mark as a debug build
#    --release ....................... [cordova] Mark as a release build
#    --device ........................ [cordova/native-run] Deploy build to a device
#    --emulator ...................... [cordova/native-run] Deploy build to an emulator
#    --no-native-run ................. [native-run] Do not use native-run to run the app; use Cordova instead
#    --connect ....................... [native-run] (--livereload) Tie the running app to the process
#    --consolelogs ................... [ng] (--livereload) Print app console logs to the terminal
#    --consolelogs-port=<port> ....... [ng] (--livereload) Use specific port for console logs server
#    --address=<address> ............. Use specific address for the dev server (default: localhost)
#    --port=<port>, -p=? ............. Use specific port for HTTP (default: 8100)
#    --devapp ........................ Publish DevApp service
#    --configuration=<conf>, -c=? .... [ng] Specify the configuration to use.
#    --source-map .................... [ng] Output source maps
#    --buildConfig=<file> ............ [cordova] Use the specified build configuration
#    --target=<target> ............... [cordova/native-run] Deploy build to a device (use --list to see all)
#    --json .......................... [native-run] (--list) Output targets in JSON
ionic cordova run android
ionic cordova run android --buildConfig=build.json
ionic cordova run android --prod --release -- -- --gradleArg=-PcdvBuildMultipleApks=true
ionic cordova run android --prod --release -- -- --keystore=filename.keystore --alias=myalias
ionic cordova run android --prod --release -- -- --minSdkVersion=21
ionic cordova run android --prod --release -- -- --versionCode=55
ionic cordova run android --prod --release --buildConfig=build.json
ionic cordova run android -l
ionic cordova run ios
ionic cordova run ios --buildConfig=build.json
ionic cordova run ios --livereload --external
ionic cordova run ios --livereload-url=http://localhost:8100
ionic cordova run ios --prod --release
ionic cordova run ios --prod --release -- --developmentTeam="ABCD" --codeSignIdentity="iPhone Developer" \
      --packageType="app-store"
ionic cordova run ios --prod --release --buildConfig=build.json