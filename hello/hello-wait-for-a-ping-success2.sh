#!/bin/bash
until nc -zv 13.112.200.162 7000; do sleep 3; done;