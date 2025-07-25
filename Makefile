# HELM_VERSION
# Only required to install a specify version
HELM_VERSION?=v3.18.4 # renovate: datasource=github-releases depName=helm/helm

# CONTAINER_RUNTIME
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image.
CONTAINER_RUNTIME?=$(shell which podman)

# HELM_IMAGE_REGISTRY_NAME
# Defines the name of the new container to be built using several variables.
HELM_IMAGE_REGISTRY_NAME?=git.cryptic.systems
HELM_IMAGE_REGISTRY_USER?=volker.raschek

HELM_IMAGE_NAMESPACE?=${HELM_IMAGE_REGISTRY_USER}
HELM_IMAGE_NAME:=helm
HELM_IMAGE_VERSION?=latest
HELM_IMAGE_FULLY_QUALIFIED=${HELM_IMAGE_REGISTRY_NAME}/${HELM_IMAGE_NAMESPACE}/${HELM_IMAGE_NAME}:${HELM_IMAGE_VERSION}

# BUILD CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/build
container-image/build:
	${CONTAINER_RUNTIME} build \
		--build-arg HELM_VERSION=${HELM_VERSION} \
		--file Dockerfile \
		--no-cache \
		--pull \
		--tag ${HELM_IMAGE_FULLY_QUALIFIED} \
		.

# DELETE CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/delete
container-image/delete:
	- ${CONTAINER_RUNTIME} image rm ${HELM_IMAGE_FULLY_QUALIFIED}

# PUSH CONTAINER IMAGE
# ==============================================================================
PHONY+=container-image/push
container-image/push:
	echo ${HELM_IMAGE_REGISTRY_PASSWORD} | ${CONTAINER_RUNTIME} login ${HELM_IMAGE_REGISTRY_NAME} --username ${HELM_IMAGE_REGISTRY_USER} --password-stdin
	${CONTAINER_RUNTIME} push ${HELM_IMAGE_FULLY_QUALIFIED}

# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}
