#Requirements:

MySQL Database

### Jobscheduler:

##### Environment Variables:

INSTALL_PATH="/opt/jobscheduler"
DATA_PATH="/opt/jobscheduler/data"
SCHEDULER_ID="scheduler"
DB_HOST=""
DB_PORT="3306"
DB_SCHEMA=""
DB_USER=""
DB_PASSWORD=""
CLUSTER_OPTION=""
LICENSE_OPTION="GPL"
LICENSE_KEY=""
JS_AGENTS=""

To use a commercial license, set LICENSE_OPTION to blank, and then set the LICENSE_KEY

To add agents, set JS_AGENTS in the format of agent_name:agent_address:agent_port,agent_name2:agent_address2:agent_port2 (Comma separated)

### JOC:

##### Environment Variables:

INSTALL_PATH="/opt/joc"
JETTY_PORT="4446"
MEM_MIN="128"
MEM_MAX="512"
THREAD_STACK_SIZE="4000"
DB_HOST=""
DB_PORT="3306"
DB_SCHEMA=""
DB_USER=""
DB_PASSWORD=""

### Agent:

No setup is required, just start the container and the agent will run
