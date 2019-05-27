#!/usr/bin/env bash

### redis
## on macos
brew install redis
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist # Start Redis server via “launchctl”.
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist # Stop Redis on autostart on computer start.
redis-cli shutdown # Stop all the clients. Perform a blocking SAVE if at least one save point is configured. Flush the Append Only File if AOF is enabled. Quit the server.
## on ubuntu
sudo systemctl start redis
sudo systemctl enable redis
sudo systemctl restart redis
sudo systemctl stop redis
