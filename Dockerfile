FROM mysql:latest
ENV MYSQL_DATABASE TheShopDB
COPY ./scripts/ /docker-entrypoint-initdb.d/