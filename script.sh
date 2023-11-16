#!/bin/bash
rake db:create
rake db:migrate
rake assets:precompile
RAILS_ENV=production bundle exec rails s

