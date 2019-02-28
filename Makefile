NAMESPACE?=zealic
REGISTRY_NAME?=$(NAMESPACE)/$(IMAGE_NAME)


ifeq ($(IMAGE_NAME),)
$(error "IMAGE_NAME is required.")
endif
ifeq ($(IMAGE_DIR),)
$(error "IMAGE_DIR is required.")
endif

build-and-push:
	cd $(IMAGE_DIR) && docker build -t ${REGISTRY_NAME} ${BUILD_OPTS} .
	docker push ${REGISTRY_NAME}
