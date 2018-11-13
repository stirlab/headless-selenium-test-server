#!/usr/bin/env bash

# Shell wrapper to pause test runs on multiple servers.

# Template name for test servers.
SERVER_NAME_TEMPLATE="webrtc-test-[%s].stirlab.net"

servers="${1}"
test_name="${2}"
script=`basename "${0}"`

usage() {

  echo "
Usage: ${script} <servers> <test_name>
  servers: Single server number (1) or range (1-5)
  test_name: Name of test to pause
"
}

if [ $# -ne 2 ]; then
  usage
  exit 1
fi

server_regex=`printf ${SERVER_NAME_TEMPLATE} "${servers}"`

salt -E "${server_regex}" cmd.run "/usr/local/bin/pause-test.sh ${test_name}"

exit $?
