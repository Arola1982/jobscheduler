#!/bin/sh
# 
# ------------------------------------------------------------
# Company: Software- und Organisations-Service GmbH
# Author : Oliver Haufe <oliver.haufe@sos-berlin.com>
# Dated  : 2017-08-16
# Purpose: starts installer 
# ------------------------------------------------------------


usage () {
  echo "usage: `basename $0` [options] [configuration-file]"
  echo "options:"
  echo "  -u, --unprivileged     installer does not ask for root privileges"
  echo "  -E                     installer calls sudo for root privileges with -E option"
  echo ""
  echo "configuration-file       for silent install, use enclosed *_install.xml"
  exit 0
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  usage
fi

JAVABINPATH=

if [ "$USER" = "root" ]; then
  echo "Please don't call this script as root"
  exit 1
fi

USE_UNPRIVILEGED="n"
SUDO_E_OPTION=""

if [ "$1" = "-u" ] || [ "$1" = "--unprivileged" ] || [ "$1" = "-E" ]; then
  if [ "$1" = "-u" ] || [ "$1" = "--unprivileged" ]; then
    USE_UNPRIVILEGED="y"
  else
    SUDO_E_OPTION="-E"
  fi
  shift
fi
if [ "$1" = "-u" ] || [ "$1" = "--unprivileged" ] || [ "$1" = "-E" ]; then
  if [ "$1" = "-u" ] || [ "$1" = "--unprivileged" ]; then
    USE_UNPRIVILEGED="y"
  else
    SUDO_E_OPTION="-E"
  fi
  shift
fi

if [ "$#" -gt 1 ]; then
  usage
fi

if [ ! -z "$1" ]; then
  CHECK_PARAM_XML=`grep "\[:choose " "$1"`
  if [ "$CHECK_PARAM_XML" != "" ]
  then
    echo "Please edit at first the file: $1"
    echo "Look to https://kb.sos-berlin.com/x/KgoCAQ for more information"
    exit 1
  fi
fi

which_return="`java -version 2>&1`"
last_exit=$?

if [ $last_exit -ne 0 ]; then
  # echo "$which_return"
  echo "java couldn't be found."
  echo "Please enter your java bin directory ([java install path]/bin):"
  read JAVABIN
  which_return="`$JAVABIN/java -version 2>&1`"
  last_exit=$?
  if [ $last_exit -ne 0 ]
  then
    echo "\"$JAVABIN/java\" couldn't be found."
    exit 1
  fi
fi

if [ "$JAVABIN" != "" ]; then
  JAVABINPATH="${JAVABIN}/"
fi

if [ "$USE_UNPRIVILEGED" = "y" ]; then
  echo "${JAVABINPATH}java -Dizpack.mode=privileged -jar \"`dirname $0`/jobscheduler_linux-x64.1.12.8.jar\" $*"
  "${JAVABINPATH}java" -Dizpack.mode=privileged -jar "`dirname $0`/jobscheduler_linux-x64.1.12.8.jar" $*
  exit 0
fi


which_return="`which sudo 2>&1`"
sudo_exit=$?
USESU=n 

export DISPLAY
if [ -f "$HOME/.Xauthority" ]
then 
  XAUTHORITY="$HOME/.Xauthority"
  export XAUTHORITY
fi

if [ $sudo_exit -eq 0 ]
then
  echo "sudo $SUDO_E_OPTION \"${JAVABINPATH}java\" -jar \"`dirname $0`/jobscheduler_linux-x64.1.12.8.jar\" $*"
  sudo $SUDO_E_OPTION "${JAVABINPATH}java" -jar "`dirname $0`/jobscheduler_linux-x64.1.12.8.jar" $*
  if [ $sudo_exit -ne 0 ]
  then
    echo "Do you want to use 'su' instead of 'sudo'? (y or n)"
    read USESU
  fi
else
  USESU=y 
fi

if [ "$USESU" = "y" ] || [ "$USESU" = "Y" ]
then
  echo "su root -c \"${JAVABINPATH}java -jar \\\"`dirname $0`/jobscheduler_linux-x64.1.12.8.jar\\\" $*\""
  su root -c "\"${JAVABINPATH}java\" -jar \"`dirname $0`/jobscheduler_linux-x64.1.12.8.jar\" $*"
fi
