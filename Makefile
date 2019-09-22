ROOTMAKE=$(MAKE) -f $(abspath $(lastword $(MAKEFILE_LIST)))
IMAGE_NAME?=$(shell basename $(IMAGE_DIR))
IMAGE_TAG?=latest
IMAGE_FILE?=Dockerfile
IMAGE_NAMESPACE?=$(or $(CI_PROJECT_NAMESPACE),zealic)
REGISTRY_NAME?=$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)

ifeq ($(IMAGE_DIR),)
$(error "IMAGE_DIR is required.")
endif

# Gitlab develop
ifeq ($(CI_COMMIT_REF_NAME),develop)
REGISTRY_NAME=${CI_REGISTRY_IMAGE}/$(IMAGE_DIR):latest
endif


build:
	@$(ROOTMAKE) -C $(IMAGE_DIR) build-image

build-image:
	@docker build -t $(REGISTRY_NAME) -f $(IMAGE_FILE) $(BUILD_OPTS) .
	@# Push image in CI environment
	@if [[ ! -z "$(CI)" ]]; then \
		$(ROOTMAKE) push; \
	fi

push:
	@if [[ "$(CI_COMMIT_REF_NAME)" = "master" ]]; then \
		$(ROOTMAKE) push-dockerhub; \
	elif [[ "$(CI_COMMIT_REF_NAME)" = "develop" ]]; then \
		$(ROOTMAKE) push-gitlab; \
	else \
		echo "Current branch is $(CI_COMMIT_REF_NAME), push ignored."; \
		exit 0; \
	fi

push-dockerhub:
	@echo Push to Dockerhub...
	@if [[ ! -z "$(DOCKER_HUB_USER)" ]]; then \
		docker login -u $(DOCKER_HUB_USER) -p $(DOCKER_HUB_PASS); \
	fi
	docker push $(REGISTRY_NAME)

push-gitlab:
	@echo Push to gitlab...
	docker push $(REGISTRY_NAME)
