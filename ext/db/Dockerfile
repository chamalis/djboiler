FROM postgres

# this script is included in case we want multiple dbs in the same container
COPY scripts/createdb.sh /docker-entrypoint-initdb.d/
RUN chmod a+x /docker-entrypoint-initdb.d/createdb.sh

# Add, and use in compose, a custom user with the SAME uid as the
# user running the docker container in the host, in order to avoid
# permission problems with mounted volumes, due to the fact that
# postgresql >= 15 container uses postgres uid:gid 999:999
#
# RUN useradd -u 1000 -M user && usermod -aG postgres user
#
# RUN chown -R user:postgres /var/run/postgresql && \
#     chown -R user:postgres /var/lib/postgresql/
