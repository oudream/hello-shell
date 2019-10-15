#!/usr/bin/env bash

# /opt/ddd/ai/numpy/numpy-ml/numpy_ml$python -c "from hmm.tests import *; test_HMM()"
python -c "from hmm.tests import *; test_HMM()"
python -c "from gmm.plots import *; plot()"

# Anaconda
# https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
# https://docs.conda.io/projects/conda/en/latest/user-guide/install/download.html
# https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
bash Anaconda-latest-Linux-x86_64.sh

conda list


# unittest
python -m unittest -h

python -m unittest test_module1 test_module2
python -m unittest test_module.TestClass
python -m unittest test_module.TestClass.test_method