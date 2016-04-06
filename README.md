# Node-Jawn-Docker

A Node.Js docker container with the purpose to be used by contributers to the Jawn project (https://github.com/CfABrigadePhiladelphia/jawn), in order to maintain a reprodusable and consistent environment to test and run their code.

## The container

The container uses Ubuntu, and installs nodejs and npm. The working directory is /app .
In addition, this container comes with an rspec test to check the container builds properly and as expected (see below).

### How to run it?

First clone this repository, then you have to build the image (make sure you are in the directory where the Dockerfile is located):

```docker build -t name-of-the-image/your-node-application .```

Once the containers image has been build, you can run it. The different commands below to run it will map your application directory into the container and anything you create or change will be automatically updated into your local computer.
To work inside the container in bash:

```docker run --rm -it -v "/Users/bvcotero/devopsing/dockerfiles/Node-Jawn-Docker/:/app/" name-of-the-image/your-node-application bash```

To work in the nodejs console:

```docker run --rm -it -v "/Users/bvcotero/devopsing/dockerfiles/Node-Jawn-Docker/:/app/" name-of-the-image/your-node-application nodejs```

And to run your application:

```docker run --rm -it -v "/Users/bvcotero/devopsing/dockerfiles/Node-Jawn-Docker/:/app/" name-of-the-image/your-node-application file-with-application```


# To test Dockerfile with rspec

This repository contains a file spec/Dockerfile_spec.rb that test that the image create functions as expected.
This test runs using a container.
After cloning this repository, install the necessary gemsto run rspec and serverspec:
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
