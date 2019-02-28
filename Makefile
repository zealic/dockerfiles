IMAGE_NAMESPACE?=$(or $(CI_PROJECT_NAMESPACE),zealic)
REGISTRY_NAME?=$(IMAGE_NAMESPACE)/$(IMAGE_NAME)

ifeq ($(IMAGE_NAMESPACE),)
$(error "IMAGE_NAMESPACE is required.")
endif
ifeq ($(IMAGE_NAME),)
$(error "IMAGE_NAME is required.")
endif
ifeq ($(IMAGE_DIR),)
$(error "IMAGE_DIR is required.")
endif

build-and-push: login
	cd $(IMAGE_DIR) && docker build -t ${REGISTRY_NAME} ${BUILD_OPTS} .
	docker push ${REGISTRY_NAME}

login:
	@if [[ ! -z "$(DOCKER_HUB_USER)" ]]; then \
		docker login -u $(DOCKER_HUB_USER) -p $(DOCKER_HUB_PASS); \
	fi
