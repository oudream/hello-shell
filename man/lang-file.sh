#!/usr/bin/env bash


-f file # file exists and is a regular file
-g file # file exists and has its setgid bit set
-G file # file exists and is owned by the effective group ID
-h file # file exists and is a symbolic link
-k file # file exists and has its sticky bit set
-L file # file exists and is a symbolic link
-N file # file was modified since it was last read
-O file # file exists and is owned by the effective user ID
-p file # file exists and is a pipe or named pipe (FIFO file)
-r file # file exists and is readable
-s file # file exists and is not empty
-S file # file exists and is a socket
-t N    # File descriptor N points to a terminal
-u file # file exists and has its setuid bit set
-w file # file exists and is writeable
-x file # file exists and is executable, or file is a directory that can be searched
fileA -nt fileB # fileA modification time is newer than fileB
fileA -ot fileB # fileA modification time is older than fileB
fileA -ef fileB # fileA and fileB point to the same file

-n string #string is non-null
-z string # string has a length of zero
stringA = stringB # stringA equals stringB (POSIX version)
stringA == stringB # stringA equals stringB
stringA != stringB # stringA does not match stringB
stringA =~ regexp # stringA matches the extended regular expression regexp[3]
stringA < stringB # stringA sorts before stringB lexicographically
stringA > stringB # stringA sorts after stringB lexicographically

exprA -eq exprB # Arithmetic expressions exprA and exprB are equal
exprA -ne exprB # Arithmetic expressions exprA and exprB are not equal
exprA -lt exprB # exprA is less than exprB
exprA -gt exprB # exprA is greater than exprB
exprA -le exprB # exprA is less than or equal to exprB
exprA -ge exprB # exprA is greater than or equal to exprB
exprA -a exprB # exprA is true and exprB is true
exprA -o exprB # exprA is true or exprB is true

