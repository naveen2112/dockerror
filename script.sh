#!/bin/bash

if [ "${*}" == "./bin/rails server"]
then
 ./bin/rails db:create
 ./bin/rails db:migrate
fi

exec "$@"

