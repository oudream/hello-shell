GDB	= @GDB@

dist_bin_SCRIPTS = dupx
dist_man_MANS = dupx.1
EXTRA_DIST = dupx.spec

.PHONY: rpm
SPECS   = ~/rpmbuild/SPECS
SOURCES = ~/rpmbuild/SOURCES
rpm:
	cp dupx.spec $(SPECS)/$(PACKAGE_NAME)-$(VERSION).spec
	make dist-gzip
	cp $(PACKAGE_TARNAME)-$(VERSION).tar.gz $(SOURCES)
	rpmbuild -ba $(SPECS)/$(PACKAGE_TARNAME)-$(VERSION).spec
