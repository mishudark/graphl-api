-include project.mk
.PHONY: help
.DEFAULT_GOAL := help
SHELL         := /bin/bash

export GOPATH  := $(HOME)
export GOBIN   := $(GOPATH)/bin
export PATH    := $(GOBIN):$(PATH)
export GOPROXY := https://goproxy.io

IMAGE_NAME          ?=
GO_MAIN_PATH        ?=
IMAGE_ENABLE        ?= false
IMAGE_BASE          ?= golang:alpine
PORT                ?= 8000
GO_BUILD_FLAGS      ?= -ldflags "-d -s -w" -tags netgo -installsuffix netgo
PACKAGE_TIMESTAMP   ?= $(shell git log -1 --format=%h)
PUBLISH             ?= false
DOCKER_PUBLISH_URL  ?=
DOCKER_PUBLISH_USER ?=
DOCKER_PUBLISH_PWD  ?=
DOCKER_PUBLISH_TAG  ?=
LINT_VERSION        ?= v1.15.0

GO_MOD_CACHE      = /go/pkg/mod

GO                := $(shell command -v go 2> /dev/null)
DOCKER            := $(shell command -v docker 2> /dev/null)
LINTER            := $(shell command -v golangci-lint 2> /dev/null)


.GOMODFILE        = go.mod
.GIT              = .git
.CACHE            = .cache
.PROJECT_MK       = project.mk
.SERVER_NAME      = server.build

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))


ifndef PACKAGE_TIMESTAMP
ifeq ($(.GIT),$(wildcard $(.GIT)))
PACKAGE_TIMESTAMP = $(shell git rev-list --max-count=1 --timestamp HEAD | awk '{print $$1}')
endif
endif

define PROJECT_MK_CONTENT
GO_MAIN_PATH  =
IMAGE_NAME = server
IMAGE_ENABLE = false
PUBLISH = false

DOCKER_PUBLISH_TAG =
DOCKER_PUBLISH_URL =
DOCKER_PUBLISH_USER =
DOCKER_PUBLISH_PWD =
endef
export PROJECT_MK_CONTENT

all:
	$(info project.mk has been created, please review the config there)

help: ## Show this help message.
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

ifneq ($(.PROJECT_MK),$(wildcard $(.PROJECT_MK)))
	@echo "$$PROJECT_MK_CONTENT" > project.mk
	$(info project.mk has been created, please review the config there)
	$(info )
else
$(call check_defined, GO_MAIN_PATH, path to the main.go package required on project.mk)

ifeq ($(IMAGE_ENABLE), true)
$(call check_defined, DOCKER, please install docker)
$(call check_defined, IMAGE_NAME, no docker image name provided)
#$(call check_defined, PACKAGE_TIMESTAMP, required)
endif

ifeq ($(IMAGE_ENABLE), false)
$(call check_defined, GO, go is required to perform this operation)
endif

ifeq ($(PUBLISH),true)
$(call check_defined, DOCKER_PUBLISH_TAG, no remote tag provided)
$(call check_defined, DOCKER_PUBLISH_URL, docker registry url required)
$(call check_defined, DOCKER_PUBLISH_USER, docker username for registry required)
$(call check_defined, DOCKER_PUBLISH_PWD, docker password for registry required)
endif

ifndef IMAGE_BUILD
define IMAGE_BUILD
FROM $(IMAGE_BASE)
RUN apk add --no-cache git
endef
export IMAGE_BUILD
endif


ifndef IMAGE_PROD
define IMAGE_PROD
$(IMAGE_BUILD)
WORKDIR /src
COPY . .
RUN mkdir -p $(GO_MOD_CACHE)
RUN mv ./$(.CACHE)/* $(GO_MOD_CACHE)
RUN GO111MODULE=on CGO_ENABLED=0 go build $(GO_BUILD_FLAGS) -o $(.SERVER_NAME) $(GO_MAIN_PATH)
RUN cp $(.SERVER_NAME) /go/bin

FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN adduser -S -D -H -h /app appuser
USER appuser
WORKDIR /go/bin
COPY --from=0 /go/bin/$(.SERVER_NAME) .
CMD ["./$(.SERVER_NAME)"]
endef
export IMAGE_PROD
endif

define IMAGE_FAST
FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN adduser -S -D -H -h /app appuser
USER appuser
WORKDIR /go/bin
COPY $(.SERVER_NAME) .
CMD ["./$(.SERVER_NAME)"]
endef
export IMAGE_FAST

image-build:
	@echo "$$IMAGE_BUILD" > .Dockerfile
	docker build -t $(IMAGE_NAME)-build -f .Dockerfile .

image-static: |static-build
	@echo "$$IMAGE_FAST" > .Dockerfile
	docker build -t $(IMAGE_NAME) -f .Dockerfile .

run-static: |image-static
	docker run -p$(PORT):$(PORT) $(IMAGE_NAME)

check-linter:
ifndef LINTER
	curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(shell go env GOPATH)/bin $(LINT_VERSION)
endif

lint: ## Lint with the standard options
	@make lint-impl
lint-impl: |check-linter
	GO111MODULE=on golangci-lint run

gomod:
ifneq ($(.GOMODFILE),$(wildcard $(.GOMODFILE)))
$(error go.mod is required)
endif

.PHONY: dockerfile
dockerfile:
	@echo "$$IMAGE_PROD" > .Dockerfile

static-build:
	GO111MODULE=on CGO_ENABLED=0 GOOS=linux go build $(GO_BUILD_FLAGS) -o $(.SERVER_NAME) $(GO_MAIN_PATH)

local-test:
	GO111MODULE=on CGO_ENABLED=0 go test ./...

cache:
ifneq ($(.CACHE),$(wildcard $(.CACHE)))
	mkdir $(.CACHE)
	touch $(.CACHE)/empty
endif

ifeq ($(IMAGE_ENABLE), true)

.PHONY: vendor
vendor: |image-build
	docker run -w /build -v $(shell pwd):/build -v $(shell pwd)/$(.CACHE):$(GO_MOD_CACHE) -e GO111MODULE=on $(IMAGE_NAME)-build go mod download

run: |cache build
	docker run -p$(PORT):$(PORT) $(IMAGE_NAME)

build: |gomod cache dockerfile
	docker build -t $(IMAGE_NAME) -f .Dockerfile .

test: |gomod cache image-build
	docker run -w /build -v $(shell pwd):/build -v $(shell pwd)/$(.CACHE):$(GO_MOD_CACHE) -e GO111MODULE=on -e CGO_ENABLED=0 $(IMAGE_NAME)-build go test $(GO_BUILD_FLAGS) ./...

endif

ifeq ($(IMAGE_ENABLE), false)
run: ## Run the project
	@make run-impl
run-impl: |gomod
	GO111MODULE=on go run $(GO_MAIN_PATH)

build: ## Build the project
	@make build-impl
build-impl: |gomod
	GO111MODULE=on go build $(GO_MAIN_PATH)

test: ## Run tests under pkg directory
	@make local-test

.PHONY: vendor
vendor: ## Download the dependencies
vendor-impl: |gomod
	GO111MODULE=on go mod download
endif
endif

publish: ## Publish a container to a docker registry [IMAGE_ENABLE and PUBLISH required]
	@docker login -u $(DOCKER_PUBLISH_USER) -p $(DOCKER_PUBLISH_PWD) $(DOCKER_PUBLISH_URL)
	docker tag $(shell docker images -q $(IMAGE_NAME)) $(DOCKER_PUBLISH_URL)/$(DOCKER_PUBLISH_TAG):$(PACKAGE_TIMESTAMP)
	docker push $(DOCKER_PUBLISH_URL)/$(DOCKER_PUBLISH_TAG):$(PACKAGE_TIMESTAMP)
