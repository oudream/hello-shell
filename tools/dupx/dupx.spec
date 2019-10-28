# $Id$

Name: dupx
Version: 0.1
Release: 1
Summary: Remap files of a running process
Group: System Environment/Base
Packager: USC/ISI LANDER
Vendor: USC/ISI LANDER
Source: %{name}-%{version}.tar.gz
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-%(%{__id_u} -n)
License: GNU GPL Version 3

Requires: gdb
Requires: bash

Prefix: /

%description
Dupx is a simple utility to remap files of an already running process.
Have you ever started a process on a remote system and after a while
realized that it is time to disconnect but the process is not done; and
you wished you had redirected input/output somewhere?  Then dupx is 
for you.

%prep
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
rm -rf $RPM_BUILD_DIR/%{source}

%setup -q -n %{name}-%{version} 

%build
#autoreconf -i
%configure

%install
%makeinstall

%clean
make uninstall >/dev/null 2>&1

%files 
%{_mandir}/man1/dupx.1.gz
%{_bindir}/dupx

%changelog
* Thu Aug 12 2010 yuri <yuri@isi.edu>
- version 0.1, first release

