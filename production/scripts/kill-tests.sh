#!/usr/bin/env bash

# Shell wrapper to kill test runs on multiple servers.

# Template name for test servers.
SERVER_NAME_TEMPLATE="webrtc-test-%s-[%s].stirlab.net"

location="${1}"
servers="${2}"
test_name="${3}"
script=`basename "${0}"`

locations="cs-mia pb-las"
valid_location=0

usage() {

  echo "
Usage: ${script} <location> <servers> <test_name>
  location: Location label, one of: ${locations}
  servers: Single server number (1) or range (1-5)
  test_name: Name of test to kill
"
}

if [ $# -ne 3 ]; then
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

salt -E "${server_regex}" cmd.run "/usr/local/bin/kill-test.sh ${test_name}"

exit $?
