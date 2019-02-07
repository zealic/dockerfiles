PROJECT_NAMESPACE:=$(if $(PROJECT_NAMESPACE),$(PROJECT_NAMESPACE),$(shell cd .. && basename `pwd`))
PROJECT_NAME:=$(if $(PROJECT_NAME),$(PROJECT_NAME),$(shell basename `pwd`))
CI_REGISTRY_IMAGE?=${PROJECT_NAMESPACE}/${PROJECT_NAME}

HABITUS_VER=1.0.4
HABITUS_URL=https://github.com/cloud66-oss/habitus/releases/download/$(HABITUS_VER)/habitus_linux_amd64


build:
	habitus

push:
	docker push  ${CI_REGISTRY_IMAGE}:latest

prepare:
	wget -qO /usr/bin/habitus $(HABITUS_URL)
	chmod +x /usr/bin/habitus
