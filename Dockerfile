FROM mysql:5.7.26
COPY init.sh /docker-entrypoint-initdb.d/
