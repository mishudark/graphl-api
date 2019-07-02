GRAPHQL_PORT     = 8000
BAZEL_VERSION    = 0.26
BAZEL_OUTPUT     = --output_base=${HOME}/bazel/output
BAZEL_REPOSITORY = --repository_cache=${HOME}/bazel/repository_cache
BAZEL_FLAGS      = --experimental_remote_download_outputs=minimal --experimental_inmemory_jdeps_files --experimental_inmemory_dotd_files

IMAGE_NAME      ?= graphql
IMAGE_BASE      ?= alpine
GO_BUILD_FLAGS  ?= -ldflags "-d -s -w" -tags netgo -installsuffix netgo

OS := linux
ifeq ($(shell uname), Darwin)
	OS = darwin
endif

run: ## Run the project
	GO111MODULE=on go run ./cmd/graphql

build: ## Build the project
	GO111MODULE=on go build -o server ./cmd/graphql

test: ## Run tests under pkg directory
	GO111MODULE=on CGO_ENABLED=0 go test ./...


bazel-install: ## Install bazel
	curl -L "https://github.com/bazelbuild/bazel/releases/download/$(BAZEL_VERSION)/bazel-$(BAZEL_VERSION)-installer-$(OS)-x86_64.sh" > install.sh
	chmod +x install.sh
	./install.sh --user
	rm -f install.sh

install-bazel: bazel-install

ifndef IMAGE_BUILD
define IMAGE_BUILD
FROM $(IMAGE_BASE)
RUN apk add --no-cache ca-certificates
WORKDIR /go/bin
COPY server .
CMD ["./server"]
endef
export IMAGE_BUILD
endif

docker-build:
	@echo "$$IMAGE_BUILD" > Dockerfile
	GO111MODULE=on GOOS=linux go build $(GO_BUILD_FLAGS) -o server ./cmd/graphql
	docker build -t $(IMAGE_NAME) .

docker-run:
	docker run -p$(GRAPHQL_PORT):$(GRAPHQL_PORT) $(IMAGE_NAME)

bazel-generate: ## Generate BUILD.bazel files
	bazel $(BAZEL_OUTPUT) run //:gazelle

bazel-deps-update: ## Update bazel dependencies based on Gopkg.lock
	bazel $(BAZEL_OUTPUT) run //:gazelle -- update-repos -from_file=go.mod

bazel-test: ## Test
	bazel $(BAZEL_OUTPUT) test $(BAZEL_REPOSITORY) $(BAZEL_FLAGS) //pkg/...

bazel-build: ## Build the project
	bazel $(BAZEL_OUTPUT) build $(BAZEL_REPOSITORY) $(BAZEL_FLAGS) //cmd/graphql:docker

bazel-run: ## Run the project inside docker
	bazel $(BAZEL_OUTPUT) run //cmd/graphql:docker -- --norun
	docker run --rm -p $(GRAPHQL_PORT):$(GRAPHQL_PORT) bazel/cmd/graphql:docker
