#!/usr/bin/env bash

#
# Created by brugnara on 03/05/19,
# @ daniele@brugnara.me
#

# Thanks and credits to: Grigorii Chudnov for the original script I only adapted to my needs
# https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86

set -x

pid=0

my_wait() {
  while [ -e /proc/$1 ]
  do
    echo "waiting for process $1"
    sleep .5
  done
  echo "process $1 is dead"
}

# SIGUSR1-handler
my_handler() {
  echo "my_handler"
}

# SIGTERM-handler
term_handler() {
  # let's get the gremlin-server pid in order to be able to kill
  # I noticed that the $pid is always 24, funny but I need to be sure.
  pid=$(ps aux | grep [j]ava | awk '{print $1}')
  if [ $pid -ne 0 ]; then
    echo "killing $pid"
    kill -SIGTERM "$pid"
    my_wait "$pid"
  fi
  echo "exiting.."
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; my_handler' SIGUSR1
trap 'kill ${!}; term_handler' SIGTERM

# run application
. /docker-entrypoint.sh conf/gremlin-server.yaml &
pid="$!"

echo "PID is $pid"

# wait forever
echo "Waiting forever!"
while true
do
  tail -f /dev/null & wait ${!}
done

echo "out of wait"
