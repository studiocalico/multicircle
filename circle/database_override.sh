#!/bin/sh
for site in `ls sites`; do
  cd sites/$site

  if [ -e TEST_ME ]; then
    echo "Installing $site"

    mkdir -p config
    echo 'test:
      adapter: mysql2
      database: $site_test
      username: ubuntu
      host: localhost
    ' > config/database.yml

    export RAILS_ENV="test"
    export RACK_ENV="test"
    bundle exec rake db:create db:schema:load --trace
    bundle exec rake db:seed --trace
  else
    echo "Skipping $site"
  fi
  
  cd ../..
done