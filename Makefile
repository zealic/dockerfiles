PROJECT_NAMESPACE:=$(if $(PROJECT_NAMESPACE),$(PROJECT_NAMESPACE),$(shell cd .. && basename `pwd`))
PROJECT_NAME:=$(if $(PROJECT_NAME),$(PROJECT_NAME),$(shell basename `pwd`))
CI_REGISTRY_IMAGE?=${PROJECT_NAMESPACE}/${PROJECT_NAME}

build:
	docker build -t ${CI_REGISTRY_IMAGE} .
