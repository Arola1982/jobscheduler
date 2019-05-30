FROM openjdk:8

MAINTAINER Adam Copley <adam.copley@arola.co.uk>

ENV TMP_INSTALL_DIR="/tmp/installation_files" \
  INSTALL_PATH="/opt/jobscheduler" \
  DATA_PATH="/opt/jobscheduler/data" \
  SCHEDULER_ID="scheduler" \
  DB_HOST="" \
  DB_PORT="3306" \
  DB_SCHEMA="" \
  DB_USER="" \
  DB_PASSWORD="" \
  CLUSTER_OPTION="" \
  LICENSE_OPTION="GPL" \
  LICENSE_KEY=""


RUN mkdir -p ${TMP_INSTALL_DIR}

COPY installation_files/* ${TMP_INSTALL_DIR}/
RUN chmod +x ${TMP_INSTALL_DIR}/*.sh

WORKDIR ${TMP_INSTALL_DIR}

RUN curl -k -o jobscheduler_linux-x64.1.12.8.tar.gz \
  https://download.sos-berlin.com/JobScheduler.1.12/jobscheduler_linux-x64.1.12.8.tar.gz && \
  tar -xvzf jobscheduler_linux-x64.1.12.8.tar.gz && \
  rm -f jobscheduler_linux-x64.1.12.8.tar.gz

CMD ./install.sh && /opt/jobscheduler/scheduler/bin/jobscheduler.sh start && ./add-agents.sh && sleep infinity
