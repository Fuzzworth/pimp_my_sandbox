#!/bin/bash
git clone https://github.com/alx-tools/Betty.git Betty
cd Betty
chmod u+x install.sh
./install.sh
cd ..
rm -rf Betty
