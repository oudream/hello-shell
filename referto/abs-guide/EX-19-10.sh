#!/bin/bash

: <<TESTVARIABLES
${HOSTNAME?}${USER?}${MAIL?} # Print error message if one of the variables not set.
TESTVARIABLES

exit $?
