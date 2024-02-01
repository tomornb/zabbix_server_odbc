FROM zabbix/zabbix-server-mysql:5.2-alpine-latest
USER root
ADD odbc.ini /etc/
#ADD osql /usr/sbin/
#RUN chmod a+X /usr/sbin/osql

#RUN apk update
#RUN apk add unixodbc unixodbc-dev
#RUN apk add gcc libc-dev g++ libffi-dev libxml2 unixodbc=2.3.7-r2 unixodbc-dev=2.3.7-r2 mariadb-dev postgresql-dev

#RUN apk del unixODBC unixODBC-dev
COPY unixODBC-2.3.0.tar.gz /tmp/
RUN tar -zxvf /tmp/unixODBC-2.3.0.tar.gz
RUN rm /tmp/unixODBC-2.3.0.tar.gz
RUN ls /tmp
RUN /tmp/unixODBC-2.3.0/configure
#RUN /tmp/unixODBC-2.3.0/configure --enable-gui=no --enable-drivers=no --enable-iconv --with-iconv-char-enc=UTF8 --with-iconv-ucode-enc=UTF16LE --libdir='/usr/lib64' --prefix='/usr' --sysconfdir='/etc'

#COPY msodbcsql-11.0.2270.0 /tmp/
#RUN /tmp/msodbcsql-11.0.2270.0/ install --force  --accept-license

### #####################################################################################################################################################
### # Install dependencies
### RUN apk --no-cache add curl gnupg
### 
### # MSSQL_VERSION can be changed, by passing `--build-arg MSSQL_VERSION=<new version>` during docker build
### ARG MSSQL_VERSION=12.0.5543.11
### ENV MSSQL_VERSION=${MSSQL_VERSION}
### 
### # Labels
### LABEL maintainer="crobles@dbamastery.com"
### LABEL org.label-schema.schema-version="1.0"
### LABEL org.label-schema.name="mssql-tools-alpine"
### LABEL org.label-schema.description="mssql-tools image alternative with Alpine"
### LABEL org.label-schema.url="http://dbamastery.com"
### 
### WORKDIR /tmp
### # Installing system utilities
### RUN apk add --no-cache curl gnupg --virtual .build-dependencies -- && \
###     # Adding custom MS repository for mssql-tools and msodbcsql
###     curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_${MSSQL_VERSION}_amd64.apk && \
###     curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_${MSSQL_VERSION}_amd64.apk && \
###     # Verifying signature
###     curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_${MSSQL_VERSION}_amd64.sig && \
###     curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_${MSSQL_VERSION}_amd64.sig && \
###     # Importing gpg key
###     curl https://packages.microsoft.com/keys/microsoft.asc  | gpg --import - && \
###     gpg --verify msodbcsql17_${MSSQL_VERSION}_amd64.sig msodbcsql17_${MSSQL_VERSION}_amd64.apk && \
###     gpg --verify mssql-tools_${MSSQL_VERSION}_amd64.sig mssql-tools_${MSSQL_VERSION}_amd64.apk && \
###     # Installing packages
###     echo y | apk add --allow-untrusted msodbcsql17_${MSSQL_VERSION}_amd64.apk mssql-tools_${MSSQL_VERSION}_amd64.apk && \
###     # Deleting packages
###     apk del .build-dependencies && rm -f msodbcsql*.sig mssql-tools*.apk
### 
### WORKDIR /
### # Adding SQL Server tools to $PATH
### ENV PATH=$PATH:/opt/mssql-tools/bin
### #CMD ["/bin/sh"]
