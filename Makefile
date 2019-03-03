IMAGE_NAME?=$(shell basename $(IMAGE_DIR))
IMAGE_TAG?=latest
IMAGE_FILE?=Dockerfile
IMAGE_NAMESPACE?=$(or $(CI_PROJECT_NAMESPACE),zealic)
REGISTRY_NAME?=$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

ifeq ($(IMAGE_DIR),)
$(error "IMAGE_DIR is required.")
endif


build:
	@$(MAKE) -C $(IMAGE_DIR) -f $(PWD)/Makefile build-image

build-image:
	@docker build -t $(REGISTRY_NAME) -f $(IMAGE_FILE) $(BUILD_OPTS) .
	@# Push image in CI environment
	@if [[ ! -z "$(CI)" ]]; then \
		$(MAKE) -f $(PWD)/Makefile push; \
	fi

push:
	@if [[ ! -z "$(DOCKER_HUB_USER)" ]]; then \
		docker login -u $(DOCKER_HUB_USER) -p $(DOCKER_HUB_PASS); \
	fi
	docker push $(REGISTRY_NAME); \
