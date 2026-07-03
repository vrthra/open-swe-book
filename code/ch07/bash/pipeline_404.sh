#!/usr/bin/env bash
# §7.4.1 Dataflow Pipelines — most frequent sources of 404 errors in the
# sample log at ../data/access.log. Run: bash pipeline_404.sh
cd "$(dirname "$0")"
cat ../data/access.log |  # read
  grep 404      |         # select
  cut -d' ' -f1 |         # project
  sort          |         # order
  uniq -c       |         # count
  sort -rn                # rank
