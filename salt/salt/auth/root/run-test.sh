#!/usr/bin/env bash

test_name=${1}
test_file=${test_name}_test.py

test_dir=/home/test/tests
log_dir=/home/test/logs

cd ${test_dir}

if [ -x ${test_file} ]; then
  sudo -H -u test DISPLAY=:0 ./${test_file} &> ${log_dir}/${test_name}.log &
  exit $?
else
  echo "
ERROR: test file ${test_file} does not exist in ${test_dir}, or is not
executable.
"
  exit 1
fi

