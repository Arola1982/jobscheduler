#!/bin/bash

# Prepare jobscheduler_install.xml
./prep-config.sh

# Install jobscheduler

cd ${TMP_INSTALL_DIR}/jobscheduler*

./setup.sh jobscheduler_install.xml
