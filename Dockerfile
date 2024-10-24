### Base ###
# Base is written primarily with production needs in mind #
# todo: split to 2 dockerfiles so that each env has its own base #

FROM python:3.11-slim AS base
LABEL builder=true

ENV PATH=/root/.local/bin:$PATH
ENV POETRY_VIRTUALENVS_CREATE=false
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential netcat-traditional libssl-dev gettext libpcre3 libpcre3-dev

# Configure user and permissions
RUN adduser --uid 1000 --disabled-password --gecos '' --home /home/user user

# The apt package for poetry is too old, use pip
RUN pip install -U --no-cache-dir --pre pip \
    && pip install --no-cache-dir poetry

# Copy only the dep files first to leverage layers
COPY poetry.lock pyproject.toml /app/

# Use system wide install
# RUN poetry config virtualenvs.create false

# Install the python packages
RUN poetry install --no-interaction --no-root --only main

# todo: note: useless for dev env cause of bind mount
# Copy the rest of the project files
COPY --chown=user:user . /app
# since /app already exists, it will retain root as owner
RUN chown user:user /app

# run the rest of the ops that change /app/* contents as user
USER user

# todo: this is not needed for dev
# precompile pyc to save some import time
RUN python3 -m compileall -b -f -q /app


### PROD ###

FROM base AS production

ENV PYTHONUNBUFFERED=1
# ENV PYTHONPATH="/app:/app/djboiler:/usr/local/lib/python3.11/dist-packages"
ENV PYTHONPATH="/app/djboiler:$PYTHONPATH"
ENV PATH="/home/user/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# COPY --from=base /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

COPY --from=base /app /app
COPY ./envs/prod/.env /app/.env

# todo fix this after splitting the dockerfiles
USER 0:0
RUN rm -rf /var/lib/apt/lists/*

# launch the app as user
USER user

# Launch the bash script starting the app
CMD ["/app/envs/prod/run.sh"]


### DEV ###

FROM base AS development

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH="/app/djboiler:$PYTHONPATH"
ENV PATH="/home/user/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Install packages as root
USER 0:0
RUN apt-get install -y --no-install-recommends \
    procps net-tools redis-tools postgresql-client iputils-ping curl \
    && rm -rf /var/lib/apt/lists/*

# Install the python packages needed for development
RUN poetry install --only dev --no-interaction --no-root

# launch the app as user
USER user
CMD ["/app/envs/dev/run.sh"]