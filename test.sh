#!/usr/bin/env bash

set -e

runmaude()  {
  maude -no-banner -no-wrap </dev/null <(echo 'set show timing off .') "$@"
}

dodiff() {
  git --no-pager diff --no-index --word-diff "$@"
}

# sanity check
runmaude p-semantics.maude

exit

for t in t/*.maude; do
  test_actual=$(mktemp -t tmp-tableaux-XXXXXX)
  runmaude "$t" &> "$test_actual"
  dodiff "$test_actual" "$t.expected"
done

echo 'Passed.'

