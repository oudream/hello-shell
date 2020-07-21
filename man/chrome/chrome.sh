#!/usr/bin/env bash

### centos
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install ./google-chrome-stable_current_*.rpm
google-chrome –version

### doc
# Run Chromium with flags:
# http://www.chromium.org/developers/how-tos/run-chromium-with-flags
# List of Chromium Command Line Switches:
# http://peter.sh/experiments/chromium-command-line-switches/
# https://superuser.com/questions/545033/google-chrome-command-line-switches
# https://source.chromium.org/chromium/chromium/src/+/master:headless/app/headless_shell_switches.cc?originalUrl=https:%2F%2Fcs.chromium.org%2F


###
# https://developers.google.com/web/updates/2017/04/headless-chrome

# Printing the DOM
# The --dump-dom flag prints document.body.innerHTML to stdout:
chrome --headless --disable-gpu --dump-dom https://www.chromestatus.com/

# Create a PDF
# The --print-to-pdf flag creates a PDF of the page:
chrome --headless --disable-gpu --print-to-pdf https://www.chromestatus.com/