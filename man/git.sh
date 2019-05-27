#!/usr/bin/env bash

### git
git submodule add https://github.com/chaconinc/DbConnector
git clone --recursive https://github.com/chaconinc/MainProject
git submodule update --remote DbConnector
git submodule update --remote

