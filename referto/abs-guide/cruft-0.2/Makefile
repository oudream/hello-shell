# Makefile for cruft
# author: Mendel Cooper <thegrendel@theriver.com>

CC = gcc
# Change to cc if you don't have gcc installed.

CFLAGS = -O2 -fomit-frame-pointer
# -mpentium
# if you have a pentium

BINS = /usr/local
# Change this if you want it installed anywhere else, for example /opt.

all: cruft keygen

cruft: cruft.c cruft.h
	$(CC) $(CFLAGS) -o cruft cruft.c
	strip cruft

keygen: keygen.c cruft.h
	$(CC) $(CFLAGS) -o keygen keygen.c
	strip keygen

# Install as root, of course.

install: install_bins install_mans

install_bins:
	cp cruft $(BINS)/bin
	cp keygen $(BINS)/bin

install_mans:
	cp cruft.1 $(BINS)/man/man1
	cp keygen.1 $(BINS)/man/man1

