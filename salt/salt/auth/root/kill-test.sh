#!/usr/bin/env bash

test_name=${1}
test_file=${test_name}_test.py

pkill -f --signal SIGINT -u test ${test_file}

# Force a clean exit even if pkill doesn't kill a process.
exit 0
