FROM ubuntu:14.04

MAINTAINER Berenice Venegas <bvcotero@gmail.com>

RUN apt-get update
 
RUN apt-get install -y nodejs npm

RUN mkdir /app/

WORKDIR /app/

CMD ['/usr/bin/nodejs']

