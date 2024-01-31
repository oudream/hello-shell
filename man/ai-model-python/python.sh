#!/usr/bin/env bash

conda list

# How do I find the location of my Python site-packages directory?
python -m site

# unittest
python -m unittest -h

python -m unittest test_module1 test_module2
python -m unittest test_module.TestClass
python -m unittest test_module.TestClass.test_method

# /opt/ddd/ai/numpy/numpy-ml/numpy_ml$python -c "from hmm.tests import *; test_HMM()"
python -c "from hmm.tests import *; test_HMM()"
python -c "from gmm.plots import *; plot()"

