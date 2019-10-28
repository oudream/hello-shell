# Autoconfigure for dupx
# $Id$

AC_INIT([dupx], [0.1], [yuri@isi.edu])
AC_CONFIG_AUX_DIR(.build-aux)
AM_INIT_AUTOMAKE()

AC_PROG_INSTALL
AC_CHECK_PROG([GDB], [gdb], [gdb])

AC_CACHE_SAVE

AC_CONFIG_FILES([Makefile])

if test -z "$GDB"; then
    AC_MSG_ERROR([gdb is not in the path, this utility requires GDB])
fi

AC_SUBST(GDB)

AC_OUTPUT

