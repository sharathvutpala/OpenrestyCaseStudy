#!/bin/bash

PATH=/opt/
GIT_PATH="https://github.com/openresty/openresty-packaging.git"

cd ${PATH}
git clone ${GIT_PATH}
cd openresty-packaging/deb/
make openresty-build
