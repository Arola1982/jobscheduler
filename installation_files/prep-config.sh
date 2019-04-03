#!/bin/bash

# Update jobscheduler_install.xml

cd ${TMP_INSTALL_DIR}/jobscheduler*

echo "Setting installation path"
sed -ri "s%\[\:choose absolute installation path of the JobScheduler\:\]%${INSTALL_PATH}%" jobscheduler_install.xml && \

echo "Setting data path"
sed -ri "s%\[\:choose absolute data path of the JobScheduler configuration and log files\:\]%${DATA_PATH}%" jobscheduler_install.xml && \

echo "Setting scheduler id"
sed -ri "s%<entry key=\"schedulerId\" value=\"scheduler\"/>%<entry key=\"schedulerId\" value=\"${SCHEDULER_ID}\"/>%" jobscheduler_install.xml

echo "Setting database host"
sed -ri "s%<entry key=\"databaseHost\" value=\"\"/>%<entry key=\"databaseHost\" value=\"${DB_HOST}\"/>%" jobscheduler_install.xml

echo "Setting database port"
sed -ri "s%<entry key=\"databasePort\" value=\"\"/>%<entry key=\"databasePort\" value=\"${DB_PORT}\"/>%" jobscheduler_install.xml

echo "Setting database schema"
sed -ri "s%<entry key=\"databaseSchema\" value=\"\"/>%<entry key=\"databaseSchema\" value=\"${DB_SCHEMA}\"/>%" jobscheduler_install.xml

echo "Setting database user"
sed -ri "s%<entry key=\"databaseUser\" value=\"\"/>%<entry key=\"databaseUser\" value=\"${DB_USER}\"/>%" jobscheduler_install.xml

echo "Setting database password"
sed -ri "s%<entry key=\"databasePassword\" value=\"\"/>%<entry key=\"databasePassword\" value=\"${DB_PASSWORD}\"/>%" jobscheduler_install.xml

echo "Setting cluster option"
sed -ri "s%<entry key=\"clusterOptions\" value=\"\"/>%<entry key=\"clusterOptions\" value=\"${CLUSTER_OPTION}\"/>%" jobscheduler_install.xml

echo "Setting license option"
sed -ri "s%<entry key=\"licenceOptions\" value=\"GPL\"/>%<entry key=\"licenceOptions\" value=\"${LICENSE_OPTION}\"/>%" jobscheduler_install.xml

echo "Setting license key"
sed -ri "s%<entry key=\"licence\" value=\"\"/>%<entry key=\"licence\" value=\"${LICENSE_KEY}\"/>%" jobscheduler_install.xml

echo "Stop jobscheduler from starting after installation"
sed -ri "s%<entry key=\"launchScheduler\" value=\"yes\"/>%<entry key=\"launchScheduler\" value=\"no\"/>%" jobscheduler_install.xml
