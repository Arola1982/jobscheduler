#!/bin/bash

# Clear log folder if already existing
LOG_DIR="/opt/jobscheduler/data/scheduler/logs"
if [ -d "${LOG_DIR}" ] ; then
  rm -rf ${LOG_DIR}
fi

# Prepare jobscheduler_install.xml
./prep-config.sh

cd ${TMP_INSTALL_DIR}/jobscheduler*

# Install jobscheduler
./setup.sh jobscheduler_install.xml
