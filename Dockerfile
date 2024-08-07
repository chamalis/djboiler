FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

ENV PYTHONPATH="/app:/app/djboiler:/usr/local/lib/python3.11/dist-packages"
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    netcat-traditional \
    libssl-dev libpcre3 libpcre3-dev \
    procps net-tools redis-tools postgresql-client iputils-ping\
    && rm -rf /var/lib/apt/lists/*

# The apt package for poetry is too old, use pip
RUN pip install -U --no-cache-dir --pre pip poetry

# Copy only the dep files first to leverage layers
COPY poetry.lock pyproject.toml /app/

# Configure Poetry to not create virtual environments
RUN poetry config virtualenvs.create false

# Use system wide install
RUN poetry config virtualenvs.create false

# Install the python packages
RUN poetry install --no-interaction --no-root --only main

# Add the application files to the image
COPY . /app/
COPY .env.docker /app/.env

# Configure user and permissions
RUN adduser --uid 1000 --disabled-password --gecos '' --home /home/user user
RUN chown user:user -R /app
USER user

# Launch the bash script starting the app
CMD ["./bin/docker/run.sh"]
