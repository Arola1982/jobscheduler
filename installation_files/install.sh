#!/bin/bash

# Prepare jobscheduler_install.xml
./prep-config.sh

cd ${TMP_INSTALL_DIR}/jobscheduler*

# Install jobscheduler
./setup.sh jobscheduler_install.xml
