#!/usr/bin/env bash

### find
macos:
touch -t "201802210444" /tmp/start
touch -t "201802210445" /tmp/end
find /usr/local/bin -newer /tmp/start -not -newer /tmp/end
linux:
touch --date "2007-01-01" /tmp/start
touch --date "2008-01-01" /tmp/end
find /data/images -type f -newer /tmp/start -not -newer /tmp/end

find . -iname "*" -type f -exec ln -s /home/oudream/untitled2/{} /fff/a \;

find . -maxdepth 1 -type d | while read dir; do count=$(find "$dir" -type f | wc -l); echo "$dir : $count"; done

# I'm trying to find files with multiple extensions in a shell script
find $DIR -name \*.jpg -o -name \*.png -o -name \*.gif -print

