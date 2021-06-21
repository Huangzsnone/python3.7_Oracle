FROM python:3.7

MAINTAINER huangzaisheng@simuwang.com

#INSTALL Packages
ADD ./instantclient_19_5.tar.gz /opt/oracle/instantclient

ENV ORACLE_HOME=/opt/oracle/instantclient
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
ENV OCI_HOME=/opt/oracle/instantclient
ENV OCI_LIB_DIR=/opt/oracle/instantclient
ENV OCI_INCLUDE_DIR=/opt/oracle/instantclient/sdk/include
ENV TIMEZONE=Asia/Shanghai

WORKDIR /

#INSTALLINS INSTANTCLIENT 
RUN apt-get update 
RUN apt-get install -y libaio1 gcc \
    && apt-get clean 
RUN pip install uvicorn fastapi redis aiofiles python-multipart sqlalchemy cx_Oracle --no-cache-dir -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com \
    && python -m pip uninstall -y pip \
    && rm -rf /root/.cache /tmp/* \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone 


VOLUME /app/config

WORKDIR /app

EXPOSE 80
