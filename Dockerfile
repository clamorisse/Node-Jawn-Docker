FROM ubuntu:14.04

MAINTAINER Berenice Venegas <bvcotero@gmail.com>

# Installs packages

RUN apt-get update 
RUN apt-get install -y curl

# Installs nodejs v0.10.x
RUN apt-get install -y nodejs nodejs-legacy npm 

# Installs nodejs v4.x
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get install -y nodejs build-essential
 
# Creates user jawn
RUN useradd --system -m -G staff --shell /usr/sbin/nologin jawn

# Creates working directory
RUN mkdir /app
WORKDIR /app
RUN chown jawn:jawn /app

# Login as user jawn
USER jawn

# Installs dependences
RUN curl --remote-name https://raw.githubusercontent.com/CfABrigadePhiladelphia/jawn/master/package.json
RUN npm install

CMD ["/usr/bin/nodejs"]
