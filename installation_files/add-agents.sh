#¡/bin/bash

PROCESS_CLASS_DIR="/opt/jobscheduler/data/scheduler/config/live/process_classes"

if [ ! -d $PROCESS_CLASS_DIR ] ; then
  mkdir -p ${PROCESS_CLASS_DIR}
fi

OLD_IFS=${IFS}
IFS=","

for AGENT in ${JS_AGENTS}
do
  AGENT_NAME=`echo ${AGENT} | cut -d ':' -f1`
  AGENT_ADDR=`echo ${AGENT} | cut -d ':' -f2`
  AGENT_PORT=`echo ${AGENT} | cut -d ':' -f3`

  echo "<process_class max_processes=\"30\" remote_scheduler=\"http://${AGENT_ADDR}:${AGENT_PORT}\"/>" > ${PROCESS_CLASS_DIR}/${AGENT_NAME}.process_class.xml
done

IFS=${OLD_IFS}
