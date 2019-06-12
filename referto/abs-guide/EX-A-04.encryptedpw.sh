#!/bin/bash

# Example "ex72.sh" modified to use encrypted password.

#  Note that this is still rather insecure,
#+ since the decrypted password is sent in the clear.
#  Use something like "ssh" if this is a concern.

E_BADARGS=85

if [ -z "$1" ]
then
  echo "Usage: `basename $0` filename"
  exit $E_BADARGS
fi  

Username=root           # Change to suit.
pword=/home/abs/A-xx/password_encrypted.file
# File containing encrypted password.

Filename=`basename $1`  # Strips pathname out of file name.

Server="127.0.0.1"
Directory="/root"         # Change above to actual server name & directory.


Password=`cruft <$pword`          # Decrypt password.
#  Uses the author's own "cruft" file encryption package, based on the 
#+ classic "onetime pad" algorithm, and obtainable from 
#+  Primary-site:   
#+ ftp://metalab.unc.edu/pub/Linux/utils/file/cruft-0.2.tar.gz
#+ Alternate-site: 
#+ http://members.tripod.com/~the_grendel/cruft.0.2.tar.gz


ftp -n $Server <<End-Of-Session
user $Username $Password
binary
bell
cd $Directory
put $Filename
bye
End-Of-Session
# -n option to "ftp" disables auto-logon.
# Note that "bell" rings 'bell' after each file transfer.

exit 0
