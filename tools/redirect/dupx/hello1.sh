#!/usr/bin/env bash

call dup2(open("/root/foo3", 7), "/proc/17296/fd/2")
