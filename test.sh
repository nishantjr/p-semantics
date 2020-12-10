#!/usr/bin/env bash

set -e

runmaude()  {
  maude -no-banner -no-wrap <(echo 'set show stats off . set show timing off .') "$@"
}

dodiff() {
  git --no-pager diff --no-index --word-diff "$@"
}

for t in t/*.maude; do
  test_actual=$(mktemp -t maude-run-XXXXXX)
  runmaude "$t" </dev/null &> "$test_actual"
  dodiff "$test_actual" "$t.expected"
done

echo 'Passed.'

