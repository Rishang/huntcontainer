maintainer = rishang
image = seccontainer
dockerHubImage = ${maintainer}/${image}

dangling = docker images --filter dangling=true
rmi = docker rmi


build:
	# build Dockerfile
	docker build -t ${image} . | tee logs

pull:
	# pull ${image} from dockerhub
	docker pull ${dockerHubImage}

push:
	# push image to dockerhub
	docker tag ${image} ${dockerHubImage}
	docker push ${dockerHubImage}

dangling_show:
	# show all dangling images
	${dangling}

run:
	# run a container
	docker run -it --rm ${image}

pullrun:
	# pull ${dockerHubImage} and run in Container
	docker run -it --rm ${dockerHubImage}

# cleaning

rmi_dangling:
	# remove all dangling images
	@echo "Removing all dangling images"
	${rmi} `${dangling} -q`

rmi_image:
	# remove ${image}
	${rmi} ${image}
 
rmi_all: rmi_dangling rmi_image

.DEFAULT_GOAL := build

