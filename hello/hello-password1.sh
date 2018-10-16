#!/bin/bash
des_pass=135246
expect -c "
spawn ssh oudream@10.31.58.75
expect \"password:\"
send \"${des_pass}\r\"
set timeout 2
expect \"*oudream@*\"
send \"touch /fff/tmp/tmp28.txt\r\"
set timeout 2
expect \"*oudream@*\"
send \"touch /fff/tmp/tmp29.txt\r\"
set timeout 1
expect eof
"
