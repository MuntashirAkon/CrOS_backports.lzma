#!/bin/bash

# Install liblzma
if ! [ -f "$HOME/include/lzma.h" ] || ! [ -f "$HOME/lib/liblzma.a" ]; then
    curl -OL http://tukaani.org/xz/xz-5.0.4.tar.gz
    tar -zxvf xz-5.0.4.tar.gz
    cd xz-5.0.4
    ./configure --prefix=$HOME
    make
    make check
    make install

    # Cleanup
    cd ..
    rm xz-5.0.4.tar.gz
    rm -R ./xz-5.0.4
fi

# Build backports.lzma for CrOS
python2.7 setup.py build
if ! [ -d ./bin/ ]; then mkdir ./bin/; fi
cp -a ./build/lib.linux-x86_64-2.7/backports ./bin/
rm -rf ./build
echo "Module is available at ./bin"
