FROM ubuntu:14.04

MAINTAINER Berenice Venegas <bvcotero@gmail.com>

RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update -y
RUN apt-get install -y nodejs


RUN mkdir /app/
WORKDIR /app/
COPY package.json /app/
RUN npm install

CMD ["/usr/bin/nodejs"]
