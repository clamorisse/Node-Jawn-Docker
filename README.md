# Node-Jawn-Docker

A Node.Js docker container with the purpose to be used by contributars to the Jawn project (https://github.com/CfABrigadePhiladelphia/jawn), in order to maintain a reproducible and consistent environment to test and run their code.

## The container

The container uses Ubuntu, and installs nodejs and npm. The working directory is /app .
In addition, this container comes with an rspec test to check the container builds properly and as expected (see below).

## Usage

**Before you start**, you need to have docker installed on your machine. Follow the instructions for your OS on the [Docker Install page](https://docs.docker.com/engine/installation/)

First clone the Node-Jawn-Docker git repository and cd into it. 

```
git clone git@github.com:clamorisse/Node-Jawn-Docker.git
cd Node-Jawn-Docker/
```

### Build the Image

Use `docker build` to build a docker image based on the Node-Jawn-Docker dockerfile. Make sure you are in the Node-Jawn-Docker directory when you run this.

```
docker build -t node-jawn/jawn .
```

_Note:_ This example creates an image called `node-jawn` and calls the application `jawn`, but you can choose any name for the image you're building and for the application. `docker build -t name-of-the-image/your-node-application .`

### Run the Image

Once the container's image has been built, you can run it. The different commands below to run it will map your application directory into the container and anything you create or change will be automatically updated into your local computer.

*Note:* these examples assume that you're in the directory where your code lives (ie. your local copy of the jawn code). If you want to explicitly tell docker where to mount the code, replace `$(pwd)` with the path to your code.

To run jawn application:

```docker run --rm node-jawn/jawn npm test```

To work in the nodejs bash, mapping your current directory:

```docker run --rm -it -v "$(pwd):/app/" node-jawn/jawn bash```

*Note:* Using this option you will remove the modules with the dependances that the container created, you could maintain those modules if you remove ```-v "$(pwd):/app/" ``` and do not map your directory. Also, if mapping make sure you do not map the modules, create modules by running npm install inside the container.

# To test Dockerfile with rspec

This repository contains a file spec/Dockerfile_spec.rb that test the image.
This test runs using a container as well.
After cloning this repository, install the necessary gems to run rspec and serverspec:
```
docker run --rm -ti \
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
