#!/bin/bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rails s

