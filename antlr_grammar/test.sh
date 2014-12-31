#!/usr/bin/env bash

set -e
set -u

source sourceme.sh
alias grun='java org.antlr.v4.runtime.misc.TestRig'

for file in $(ls data/*.lbl | grep -v invalid)
do
  out=$(diagrun $file 2>&1)
  if [ -n "$out" ]
  then
    echo
    echo "Error in $file"
    echo "$out"
  fi
done
