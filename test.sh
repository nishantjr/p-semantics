#!/usr/bin/env bash

set -e

for file in t/*.maude
do
  echo "==== $file"
  out=$( ($MAUDE $file) 2>&1 )
  if [[ $out =~ "no parse" ]];
  then
    echo "[Parse Failure]: $file"
    exit 1
  fi
done
