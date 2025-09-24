#!/bin/sh

# Exit on error
set -e

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL..."
while ! nc -z $HOST $POSTGRES_PORT; do
  sleep 1
done
echo "PostgreSQL RENDER DB is up!"

# Apply migrations and collect static files
python manage.py migrate
python manage.py collectstatic --noinput

exec "$@"
