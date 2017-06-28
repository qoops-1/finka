#!/bin/bash
set -e

bundle check || bundle install
rm -rf tmp

host="$1"
while ! nc -z db $host; do sleep 3; done
bundle exec rails db:create db:migrate db:seed RAILS_ENV=production

bundle exec rails s -p 3000 -b '0.0.0.0' -e production