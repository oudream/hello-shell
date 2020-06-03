#!/usr/bin/env bash

runas /user:<localmachinename>\administrator cmd
runas /user:administrator cmd

# windows
mklink /D oudream C:\Users\user\iCloudDrive\oudream
mklink /D bizpower D:\twant\bizpower
mklink /D bizpower C:\Users\user\iCloudDrive\oudream\bizpower


# macos
ln -s /Users/oudream/Library/Mobile Documents/com~apple~CloudDocs/oudream oudream

