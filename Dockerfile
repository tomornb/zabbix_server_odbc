FROM zabbix/zabbix-server-mysql:5.2-alpine-latest
RUN apk update
RUN apk add gcc libc-dev g++ libffi-dev libxml2 unixodbc unixodbc-dev mariadb-dev postgresql-dev
