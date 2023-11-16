#!/bin/bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake assets:precompile
bundle exec rails s -b 0.0.0.0

