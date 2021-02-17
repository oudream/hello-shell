### github.com/microsoft/recommenders
- https://github.com/microsoft/recommenders/blob/main/examples/00_quick_start/sar_movielens.ipynb

### install conda in colab
- https://github.com/donaldsrepo/SampleNotebooks/blob/master/CondaCreateEnv/GoogleColabCondaCreateEnv.ipynb
```jupyterpython
# try to run the bare minimum to get a new conda env working
conda_path = ''
try:
    conda_path = !which conda
finally:
    print('')

if (len(conda_path) == 0):
    print('installing miniconda')
    !wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh && bash Anaconda3-2020.11-Linux-x86_64.sh -bfp /usr/local
    !conda update conda -y -q
    !source /usr/local/etc/profile.d/conda.sh
    !conda init 
    !conda install -n root _license -y -q
else:
    print('found miniconda')

conda_envs = !conda env list
res = [i for i in conda_envs if 'test36' in i]
if (len(res) == 0):
    print('not found test36 env', len(res))
    !conda create -y -q --name test36 python=3.6 libarchive cartopy
else:
    print('found test36 env', len(res))
```

###
```jupyterpython
! git clone https://github.com/Microsoft/Recommenders \
    && cd Recommenders && python tools/generate_conda_file.py \
    && conda env create -f reco_base.yaml && conda activate reco_base \
    && python -m ipykernel install --user --name reco_base --display-name "Python (reco)"

! cd Recommenders && conda env create -f reco_base.yaml && conda activate reco_base

```

###
- https://anaconda.org/conda-forge/scrapbook
```jupyterpython
!conda install -c conda-forge scrapbook
```
