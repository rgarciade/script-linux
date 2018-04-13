#!/bin/bash
# -*- ENCODING: UTF-8 -*-

echo 'version a instalar:'
read VERSION
echo ${VERSION}
echo "es la version"${VERSION}"--"
sudo apt-get remove -y nodejs
curl -sL https://deb.nodesource.com/setup_${VERSION}.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
