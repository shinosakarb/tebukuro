#!/bin/sh

set -e

host="$DATABASE_HOST"
user="$DATABASE_USERNAME"
export PGPASSWORD="$DATABASE_PASSWORD"
cmd="$@"

echo "Waiting for psql"
until psql -h "$host" -U "$user" -c '\l' &> /dev/null
do
  >$2 echo -n "."
  sleep 1
done

>&2 echo "PostgreSQL is up - executing command"
exec $cmd
