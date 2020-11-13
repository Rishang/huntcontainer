# Sec Container

## A Docker image containing setup of great sec tools

**requirements:** Having Docker installed.

Directly pull from dockerhub:

> `docker pull rishang/seccontainer`

Or

> `git clone https://github.com/Rishang/seccontainer.git; cd seccontainer`

> `docker build -t seccontainer .`

> `docker run -it -v $YourWorkDir:/root/test --name="testing" seccontainer`
