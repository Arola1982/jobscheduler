#!/bin/sh
#
#--------------------------------#
# Modified for docker
#--------------------------------#


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

${JAVABINPATH}java -jar `dirname $0 /jobscheduler_linux-x64.1.12.8.jar $*`
