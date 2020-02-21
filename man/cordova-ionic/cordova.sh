#!/usr/bin/env bash

open https://cordova.apache.org/docs/en/latest/reference/cordova-cli/index.html
open https://cordova.apache.org/docs/zh-cn/latest/guide/cli/index.html

# Syntax
cordova <command> [options] -- [platformOpts]

# Global Command List
# These commands are available at all times.
 create	    # Create a project
 help	    # Get help for a command
 telemetry	# Turn telemetry collection on or off
 config	    # Set, get, delete, edit, and list global cordova options

# Project Command List
# These commands are supported when the current working directory is a valid Cordova project.
 info	        # Generate project information
 requirements	# Checks and print out all the installation requirements for platforms specified
 platform	    # Manage project platforms
 plugin	        # Manage project plugins
 prepare	    # Copy files into platform(s) for building
 compile        # Build platform(s)
 clean	        # Cleanup project from build artifacts
 run	        # Run project (including prepare && compile)
 serve	        # Run project with a local webserver (including prepare)

# Common options
# These options apply to all cordova-cli commands.
 -d or --verbose	    # Pipe out more verbose output to your shell. You can also subscribe to log and warn events if you are consuming cordova-cli as a node module by calling cordova.on('log', function() {}) or cordova.on('warn', function() {}).
 -v or --version	    # Print out the version of your cordova-cli install.
 --no-update-notifier	# Will disable updates check. Alternatively set "optOut": true in ~/.config/configstore/update-notifier-cordova.json or set NO_UPDATE_NOTIFIER environment variable with any value (see details in update-notifier docs).
 --nohooks	            # Suppress executing hooks (taking RegExp hook patterns as parameters)
 --no-telemetry	        # Disable

# Platform-specific options
# Certain commands have options (platformOpts) that are specific to a particular platform.
# They can be provided to the cordova-cli with a '--' separator that stops the command
# parsing within the cordova-lib module and passes through rest of the options for platforms to parse

# Examples
# This example demonstrates how cordova-cli can be used to create a project with the camera plugin and run it for android platform. In particular, platform specific options like --keystore can be provided:
# Create a cordova project
cordova create myApp com.myCompany.myApp myApp
cd myApp
# Add camera plugin to the project and remember that in config.xml & package.json.
cordova plugin add cordova-plugin-camera
# Add camera plugin to the project and remember that in config.xml and package.json.
cordova plugin add cordova-plugin-camera
# Add android platform to the project and remember that in config.xml & package.json.
cordova platform add android
# Check to see if your system is configured for building android platform.
cordova requirements android
# Build the android and emit verbose logs.
cordova build android --verbose
# Run the project on the android platform.
cordova run android
# Build for android platform in release mode with specified signing parameters.
cordova build android --release -- --keystore="..\android.keystore" --storePassword=android --alias=mykey

