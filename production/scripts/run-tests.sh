#!/usr/bin/env bash

# Shell wrapper to start test runs on multiple servers.

# Template name for test servers.
SERVER_NAME_TEMPLATE="webrtc-test-[%s].stirlab.net"

servers="${1}"
test_name="${2}"
test_data="${3}"
script=`basename "${0}"`

usage() {

  echo "
Usage: ${script} <servers> <test_name> [data]
  servers: Single server number (1) or range (1-5)
  test_name: Name of test to run
  data: Optional comma-separated data to pass to the run-test.sh script.
"
}

if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  usage
  exit 1
fi

server_regex=`printf ${SERVER_NAME_TEMPLATE} "${servers}"`

salt -E "${server_regex}" cmd.run "/usr/local/bin/run-test.sh ${test_name} ${test_data}"

exit $?

