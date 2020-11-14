# Sec Container

## A Docker image containing setup of great sec tools

**requirements:** Having Docker installed.

## Installation
Directly pull from dockerhub (Easyway):

> `docker pull rishang/seccontainer`

> `docker run -it -v $YourWorkDir:/root/test --name="testing" seccontainer`

Or

> `git clone https://github.com/Rishang/seccontainer.git; cd seccontainer`

> `docker build -t seccontainer .`

> `docker run -it -v $YourWorkDir:/root/test --name="testing" seccontainer`

---------

The `unminify` command is for adding more tools based on category
