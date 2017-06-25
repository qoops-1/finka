#!/bin/bash
set -e

host="$1"
while ! nc -z db $host; do sleep 3; done

bundle check || bundle install
rm -rf tmp
bundle exec rails db:create db:migrate
bundle exec rails s -p 3000 -b '0.0.0.0'