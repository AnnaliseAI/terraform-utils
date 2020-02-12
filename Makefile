NAME='terraform-utils'
DOCKERHUB_NAMESPACE='annaliseai'

build:
	docker build . -t ${NAME}

tag:
	docker tag ${NAME}:latest ${DOCKERHUB_NAMESPACE}/${NAME}:latest

login:
	docker login -u ${DOCKERHUB_NAMESPACE}

push:
	docker push ${DOCKERHUB_NAMESPACE}/${NAME}:latest
