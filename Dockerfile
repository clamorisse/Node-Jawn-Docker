FROM ubuntu:14.04

MAINTAINER Berenice Venegas <bvcotero@gmail.com>

RUN apt-get update 
RUN apt-get install -y nodejs nodejs-legacy npm 
RUN apt-get install -y curl
#RUN curl --remote-name https://raw.githubusercontent.com/CfABrigadePhiladelphia/jawn/master/package.json


RUN useradd --system -m -G staff --shell /usr/sbin/nologin jawn

RUN mkdir /app
WORKDIR /app
RUN curl --remote-name https://raw.githubusercontent.com/CfABrigadePhiladelphia/jawn/master/package.json
RUN npm install

#RUN mkdir /app
#WORKDIR /app

USER jawn

CMD ["nodejs"]
