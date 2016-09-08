# Node-Jawn-Docker

A Node.Js docker container with the purpose to be used by contributors to the Jawn project (https://github.com/CfABrigadePhiladelphia/jawn), in order to maintain a reproducible and consistent environment to test and run their code.

## The container

The container uses Ubuntu, and installs nodejs v4.x. The working directory is /app.
In addition, this container comes with an rspec test to check the container builds properly and as expected (see below).

## Getting Docker (Required)

**Before you start**, you need to have docker installed on your machine. Follow the instructions for your OS on the [Docker Install page](https://docs.docker.com/engine/installation/)

## Getting the Image

If you don't want to build this image yourself, you can use the [copy from dockerhub](https://hub.docker.com/r/jawn/node-jawn/) by running

```
docker pull jawn/node-jawn
```

If you want to build the image yourself from our Dockerfile, follow the [the build instructions below](#build-the-image).

## Using the Image

Whether you've installed the jawn/node-jawn image from dockerhub or built the image from the Dockerfile using [the instructions below](#build-the-image), these commands show you how to use the image to do things like test the jawn code or work in a bash terminal.

The commands use docker's `-v` flag to tell the docker container where to find your source code. For example, if your code is at `/path/to/jawn`, you can make that code visible to the container using `-v "/path/to/jawn:/app"`.  If you change those files in /path/to/jawn the changes will be visible to the container. Likewise if the container changes those files (for example installing modules into node_modules), those changes will be visible to you on your filesystem.

### First run `npm install`:

**You must do this before trying to run `npm test`**

This will tell npm to install your application's Node dependencies. It will read `/path/to/jawn/package.json` and install all of the dependencies listed in that file.  The dependencies get installed to `/path/to/jawn/node_modules`

```
docker run --rm \
       -v "/path/to/jawn:/app" \
       jawn/node-jawn \
       npm install
```

### Run `npm test`:
Run jawn's test suite using `npm test`

```
docker run --rm \
       -v "/path/to/jawn:/app" \
       jawn/node-jawn \
       npm test
```

### Run a bash terminal:

To work in a bash terminal within the container, include  the `-it` flags and tell docker to run `bash`

```
docker run --rm -it \
       -v "/path/to/jawn:/app" \
       jawn/node-jawn \
       bash
```

## Building the Image
_If you don't want to build the image yourself, you can use the copy from dockerhub. See [Getting the Image](#getting-the-image)_


### Clone the Repo

First clone the Node-Jawn-Docker git repository and cd into it.

```
git clone git@github.com:clamorisse/Node-Jawn-Docker.git
cd Node-Jawn-Docker/
```

### Build the Image

Use `docker build` to build a docker image based on the Node-Jawn-Docker dockerfile. Make sure you are in the Node-Jawn-Docker directory when you run this.

```
docker build -t jawn/node-jawn .
```

_Note:_ This example creates an image called `node-jawn` from the user `jawn`, but you can choose any name for the image you're building and for the application. `docker build -t user/your-image-name .`

# Video: Building the Image and Running It

[![asciicast](https://asciinema.org/a/32qm7ro3yw1ss0qvccgv7oafl.png)](https://asciinema.org/a/32qm7ro3yw1ss0qvccgv7oafl)

# To test Dockerfile with rspec

This repository contains a file spec/Dockerfile_spec.rb that test the image.
This test runs using a container as well.
After cloning this repository, install the necessary gems to run rspec and serverspec:
```
docker run --rm -it \
       --net host  \
       --name ruby \
       -e BUNDLE_PATH=/usr/src/app/rubies \
       -e BUNDLE_BIN=/usr/src/app/rubies \
       -e BUNDLE_APP_CONFIG=/usr/src/app/rubies \
       -e GEM_HOME=/usr/src/app/rubies \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v "$PWD":/usr/src/app \
       -e PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/src/app:/usr/src/app/rubies \
       -w /usr/src/app ruby:2.1  \
       bundler install
```
then run test by replacing ```bundler install``` with ```rspec```.

[![asciicast](https://asciinema.org/a/7tlmvef67ob9zzvhvr8p1eqa0.png)](https://asciinema.org/a/7tlmvef67ob9zzvhvr8p1eqa0)

For more information on how to use rspec and serverspec to run test on a dockerfile check this other works and repositories:

https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec

https://github.com/swipely/docker-api

http://serverspec.org/

### NOTES:
Once in a while, there is a need to maintain the virtual machine clean of intermediated images and exited containers
in order to have docker container running properly.
To delete intermidiate images:

```docker rmi $(docker images | grep "^<none>" | awk '{print$3}')```

and to delete exited containers:

```docker rm $(docker ps --all -q -f status=exited)```
