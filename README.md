# Sec Container

## A Docker image containing setup of great sec tools

**requirements:** Having Docker installed.
> git clone ; cd seccontainer

> docker build -t seccontainer .

> docker run -it -v $workDir:/root/test --name="testing" seccontainer