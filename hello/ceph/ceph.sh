#!/usr/bin/env bash

# You can clone from github with
git clone git@github.com:ceph/ceph

# or, if you are not a github user,
git clone git://github.com/ceph/ceph

# Ceph contains many git submodules that need to be checked out with
git submodule update --init --recursive
# Submodule 'ceph-erasure-code-corpus' (https://github.com/ceph/ceph-erasure-code-corpus.git) registered for path 'ceph-erasure-code-corpus'
# Submodule 'ceph-object-corpus' (https://github.com/ceph/ceph-object-corpus.git) registered for path 'ceph-object-corpus'
# Submodule 'src/blkin' (https://github.com/ceph/blkin) registered for path 'src/blkin'
# Submodule 'src/c-ares' (https://github.com/ceph/c-ares.git) registered for path 'src/c-ares'
# Submodule 'src/civetweb' (https://github.com/ceph/civetweb) registered for path 'src/civetweb'
# Submodule 'src/crypto/isa-l/isa-l_crypto' (https://github.com/01org/isa-l_crypto) registered for path 'src/crypto/isa-l/isa-l_crypto'
# Submodule 'src/dmclock' (https://github.com/ceph/dmclock.git) registered for path 'src/dmclock'
# Submodule 'src/erasure-code/jerasure/gf-complete' (https://github.com/ceph/gf-complete.git) registered for path 'src/erasure-code/jerasure/gf-complete'
# Submodule 'src/erasure-code/jerasure/jerasure' (https://github.com/ceph/jerasure.git) registered for path 'src/erasure-code/jerasure/jerasure'
# Submodule 'src/fmt' (https://github.com/ceph/fmt.git) registered for path 'src/fmt'
# Submodule 'src/googletest' (https://github.com/ceph/googletest) registered for path 'src/googletest'
# Submodule 'src/isa-l' (https://github.com/ceph/isa-l) registered for path 'src/isa-l'
# Submodule 'src/lua' (https://github.com/ceph/lua.git) registered for path 'src/lua'
# Submodule 'src/rapidjson' (https://github.com/ceph/rapidjson) registered for path 'src/rapidjson'
# Submodule 'src/rocksdb' (https://github.com/ceph/rocksdb) registered for path 'src/rocksdb'
# Submodule 'src/seastar' (https://github.com/ceph/seastar.git) registered for path 'src/seastar'
# Submodule 'src/spdk' (https://github.com/ceph/spdk.git) registered for path 'src/spdk'
# Submodule 'src/xxHash' (https://github.com/ceph/xxHash.git) registered for path 'src/xxHash'
# Submodule 'src/zstd' (https://github.com/facebook/zstd) registered for path 'src/zstd'
