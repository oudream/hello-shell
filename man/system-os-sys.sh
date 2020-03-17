#!/usr/bin/env bash

# How to discover number of *logical* cores on Mac OS X?
# https://developer.apple.com/documentation/foundation/processinfo/1415622-processorcount
sysctl -n hw.ncpu

