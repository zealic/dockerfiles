IMAGE_FILE?=Dockerfile
IMAGE_TAG?=latest
IMAGE_NAMESPACE?=$(or $(CI_PROJECT_NAMESPACE),zealic)
REGISTRY_NAME?=$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

ifeq ($(IMAGE_NAMESPACE),)
$(error "IMAGE_NAMESPACE is required.")
endif
ifeq ($(IMAGE_NAME),)
$(error "IMAGE_NAME is required.")
endif
ifeq ($(IMAGE_DIR),)
$(error "IMAGE_DIR is required.")
endif


build-and-push:
	cd $(IMAGE_DIR) && docker build -t $(REGISTRY_NAME) -f $(IMAGE_FILE) $(BUILD_OPTS) .
	# Push image in CI environment
	@if [[ ! -z "$(CI)" ]]; then \
		make push; \
	fi

push:
	@if [[ ! -z "$(DOCKER_HUB_USER)" ]]; then \
		docker login -u $(DOCKER_HUB_USER) -p $(DOCKER_HUB_PASS); \
	fi
	docker push $(REGISTRY_NAME); \
