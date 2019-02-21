run: ## Run the project
	GO111MODULE=on go run ./cmd/graphql

test: ## Run tests under pkg directory
	GO111MODULE=on go test ./pkg/...

GRAPHQL_PORT = 8000
BAZEL_VERSION = 0.22.0

OS := linux
ifeq ($(shell uname), Darwin)
	OS = darwin
endif

bazel-install: ## Install bazel
	curl -L "https://github.com/bazelbuild/bazel/releases/download/$(BAZEL_VERSION)/bazel-$(BAZEL_VERSION)-installer-$(OS)-x86_64.sh" > install.sh
	chmod +x install.sh
	./install.sh --user
	rm -f install.sh

install-bazel: bazel-install

bazel-generate: ## Generate BUILD.bazel files
	bazel run //:gazelle

bazel-deps-update: ## Update bazel dependencies based on Gopkg.lock
	bazel run //:gazelle -- update-repos -from_file=go.mod

bazel-test: ## Test
	bazel test //pkg/...

bazel-build: ## Build the project
	bazel build --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64 //cmd/graphql:docker

bazel-run: ## Run the project inside docker
	bazel run --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64 //cmd/graphql:docker -- --norun
	docker run --rm -p $(GRAPHQL_PORT):$(GRAPHQL_PORT) bazel/cmd/graphql:docker
