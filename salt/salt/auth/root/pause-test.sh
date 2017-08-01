#!/usr/bin/env bash

script=`basename "${0}"`

usage() {

  echo "
Usage: ${script} <test_name>
  test_name: Name of test to pause (leave off the '_test.py' extension).
"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

test_name=${1}
test_file=${test_name}_test.py

pkill -f --signal SIGUSR1 -u test ${test_file}

# Force a clean exit even if pkill doesn't kill a process.
exit 0
