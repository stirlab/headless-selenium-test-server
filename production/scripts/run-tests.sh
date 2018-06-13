#!/usr/bin/env bash

# Shell wrapper to start test runs on multiple servers.

# Template name for test servers.
SERVER_NAME_TEMPLATE="webrtc-test-%s-[%s].stirlab.net"

location="${1}"
servers="${2}"
test_name="${3}"
test_data="${4}"
script=`basename "${0}"`

locations="cs-wdc"
valid_location=0

usage() {

  echo "
Usage: ${script} <location> <servers> <test_name> [data]
  location: Location label, one of: ${locations}
  servers: Single server number (1) or range (1-5)
  test_name: Name of test to run
  data: Optional comma-separated data to pass to the run-test.sh script.
"
}

if [ $# -lt 3 ] || [ $# -gt 4 ]; then
  usage
  exit 1
fi

for l in ${locations}; do
  if [ "${location}" = "${l}" ]; then
    valid_location=1
  fi
done

if [ ${valid_location} -eq 0 ]; then
  echo "ERROR: Invalid location"
  usage
  exit 1
fi

server_regex=`printf ${SERVER_NAME_TEMPLATE} "${location}" "${servers}"`

salt -E "${server_regex}" cmd.run "/usr/local/bin/run-test.sh ${test_name} ${test_data}"

exit $?

