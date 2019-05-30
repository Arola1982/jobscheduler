#!/bin/bash

# Prepare jobscheduler_install.xml
./prep-config.sh

cd ${TMP_INSTALL_DIR}/jobscheduler*

# Overwrite setup.sh
cp -f ../setup.sh setup.sh

# Install jobscheduler
./setup.sh jobscheduler_install.xml
