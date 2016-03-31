FROM ubuntu:14.04

MAINTAINER Berenice Venegas <bvcotero@gmail.com>

RUN apt-get update
 
RUN apt-get install nodejs 
	nodejs \
	nodejs-legacy \
	npm

RUN npm install -g express-generator

RUN mkdir /app/

WORKDIR /app/
