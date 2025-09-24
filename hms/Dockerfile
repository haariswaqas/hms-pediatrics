FROM python:3.12.6-alpine

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apk update \
    && apk add --no-cache gcc musl-dev postgresql-dev python3-dev libffi-dev netcat-openbsd zlib zlib-dev jpeg-dev

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

# 👇 Ensure whitenoise is installed
RUN pip install whitenoise

# Copy entrypoint and set executable permissions
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Copy the rest of the application code
COPY . /usr/src/app/

# 👇 Collect static files at build time (optional, you can also leave it to docker-compose)
RUN python manage.py collectstatic --noinput || true

# Default entrypoint
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
