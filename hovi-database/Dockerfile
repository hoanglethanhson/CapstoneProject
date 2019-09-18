FROM mysql:5.7

# needed for intialization
ENV MYSQL_ROOT_PASSWORD=root

COPY dump.sql /docker-entrypoint-initdb.d/
COPY ./config/my.cnf /etc/mysql/conf.d/

EXPOSE 3306
