FROM ubuntu:14.04

MAINTAINER Berenice Venegas <bvcotero@gmail.com>

# Installs packages

RUN apt-get update 
RUN apt-get install -y nodejs nodejs-legacy npm 
RUN apt-get install -y curl

# Creates user jawn
RUN useradd --system -m -G staff --shell /usr/sbin/nologin jawn

# Creates working directory
RUN mkdir /app
WORKDIR /app

# Installs dependences
RUN curl --remote-name https://raw.githubusercontent.com/CfABrigadePhiladelphia/jawn/master/package.json
RUN npm install

# Login as user jawn
USER jawn

CMD ["/usr/bin/nodejs"]
