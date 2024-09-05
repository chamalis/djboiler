FROM postgres

# These values are defined in .env and passed through docker-compose.yml
ARG UID
ARG GID

# Specify the owner of the pgdata thats also mounted in the host
# with the same uid:gid, to avoid getting an arbitrary uid:gid
RUN groupmod -g $GID postgres && \
    usermod -u $UID -g $GID -d /var/lib/postgresql postgres && \
    chown -R $UID:$GID /var/lib/postgresql/data && \
    chown -R $UID:$GID /var/run/postgresql

# this script is included in case we want multiple dbs in the same container
COPY scripts/createdb.sh /docker-entrypoint-initdb.d/
RUN chmod a+x /docker-entrypoint-initdb.d/createdb.sh

# Run everything else (official image) as "postgres" user
USER postgres
