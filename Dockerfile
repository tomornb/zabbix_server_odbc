FROM zabbix/zabbix-server-mysql:5.2-alpine-latest
USER root
ADD odbc.ini /etc/
ADD osql /usr/sbin/
RUN apk update
RUN apk add curl gpg
#RUN apk add gcc libc-dev g++ libffi-dev libxml2 unixodbc unixODBC-devel.x86_64 freetds.x86_64 freetds-devel.x86_64

#case $(uname -m) in
#    x86_64)   architecture="amd64" ;;
#    arm64)   architecture="arm64" ;;
#    *) architecture="unsupported" ;;
#esac
#if [[ "unsupported" == "amd64" ]];
#then
#    echo "Alpine architecture $(uname -m) is not currently supported.";
#    exit;
#fi

#Download the desired package(s)
curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/msodbcsql18_18.3.2.1-1_amd64.apk
curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/mssql-tools18_18.3.1.1-1_amd64.apk

#(Optional) Verify signature, if 'gpg' is missing install it using 'apk add gnupg':
curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/msodbcsql18_18.3.2.1-1_amd64.sig
curl -O https://download.microsoft.com/download/3/5/5/355d7943-a338-41a7-858d-53b259ea33f5/mssql-tools18_18.3.1.1-1_amd64.sig

curl https://packages.microsoft.com/keys/microsoft.asc  | gpg --import -
gpg --verify msodbcsql18_18.3.2.1-1_amd64.sig msodbcsql18_18.3.2.1-1_amd64.apk
gpg --verify mssql-tools18_18.3.1.1-1_amd64.sig mssql-tools18_18.3.1.1-1_amd64.apk

#Install the package(s)
apk add --allow-untrusted msodbcsql18_18.3.2.1-1_amd64.apk
apk add --allow-untrusted mssql-tools18_18.3.1.1-1_amd64.apk
