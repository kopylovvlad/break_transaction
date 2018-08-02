#!/bin/sh
set -e

CONTAINER_TIMEZONE=Europe/Moscow
echo ${CONTAINER_TIMEZONE} > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
echo "Container timezone set to: $CONTAINER_TIMEZONE"

postgres_host=$1
postgres_port=$2
shift 2
cmd="$@"

# wait for the postgres docker to be running
while ! pg_isready -h $postgres_host -p $postgres_port -q -U postgres; do
  echo "Waiting for PSQL"
  sleep 1
done
echo "PSQL is ready"

bundle exec rake db:create
bundle exec rake db:migrate

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# bundle exec puma -C config/puma.rb
bundle exec rake users:create
