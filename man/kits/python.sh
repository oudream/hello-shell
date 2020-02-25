#!/usr/bin/env bash

conda list

# unittest
python -m unittest -h

python -m unittest test_module1 test_module2
python -m unittest test_module.TestClass
python -m unittest test_module.TestClass.test_method

# /opt/ddd/ai/numpy/numpy-ml/numpy_ml$python -c "from hmm.tests import *; test_HMM()"
python -c "from hmm.tests import *; test_HMM()"
python -c "from gmm.plots import *; plot()"

# Anaconda
open https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
open https://docs.conda.io/projects/conda/en/latest/user-guide/install/download.html
# open https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
wget -O Anaconda-latest-Linux-x86_64.sh https://repo.anaconda.com/archive/Anaconda3-2019.10-MacOSX-x86_64.sh
bash Anaconda-latest-Linux-x86_64.sh

open https://docs.conda.io/projects/conda/en/latest/commands.html
usage: conda [-h] [-V] command ...
# conda is a tool for managing and deploying applications, environments and packages.
# Options:
# positional arguments:
#   command
    clean        # Remove unused packages and caches.
    config       # Modify configuration values in .condarc. This is modeled
                 # after the git config command. Writes to the user .condarc
                 # file (/root/.condarc) by default.
    create       # Create a new conda environment from a list of specified
                 # packages.
    help         # Displays a list of available conda commands and their help
                 # strings.
    info         # Display information about current conda install.
    init         # Initialize conda for shell interaction. [Experimental]
    install      # Installs a list of packages into a specified conda
                 # environment.
    list         # List linked packages in a conda environment.
    package      # Low-level conda package utility. (EXPERIMENTAL)
    remove       # Remove a list of packages from a specified conda environment.
    uninstall    # Alias for conda remove.
    run          # Run an executable in a conda environment. [Experimental]
    search       # Search for packages and display associated information. The
                 # input is a MatchSpec, a query language for conda packages.
                 # See examples below.
    update       # Updates conda packages to the latest compatible version.
    upgrade      # Alias for conda update.

# optional arguments:
#   -h, --help     Show this help message and exit.
#   -V, --version  Show the conda version number and exit.