#!/bin/sh
for site in `ls sites`; do
  cd sites/$site

  if [ -e TEST_ME ]; then
    echo "Bundling $site"
    bundle check --path=vendor/bundle || bundle install --path=vendor/bundle --jobs=4 --retry=3
  else
    echo "Skipping $site"
  fi

  cd ../..
done