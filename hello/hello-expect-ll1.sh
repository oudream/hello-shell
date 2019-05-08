#!/usr/bin/expect
set timeout 5
spawn sudo ls -l
expect "Password:"
send "oudream\r"
interact
