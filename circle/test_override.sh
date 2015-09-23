#!/bin/sh
# we pass in the site name as first param so we can see on circle which command is being run, but we don't want
# to pass it along
shift

if [ -e TEST_ME ]; then
  bin/rspec --format RspecJunitFormatter --out $CIRCLE_TEST_REPORTS/rspec.xml --format progress $@
else
  echo "Skipping"
fi