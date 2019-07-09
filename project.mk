GRAPHQL_PORT     = 8000
BAZEL_VERSION    = 0.26
PREFIX = ${HOME}
BAZEL_OUTPUT     = --output_base=${PREFIX}/bazel/output
BAZEL_REPOSITORY = --repository_cache=${PREFIX}/bazel/repository_cache
BAZEL_FLAGS      = --experimental_remote_download_outputs=minimal --experimental_inmemory_jdeps_files --experimental_inmemory_dotd_files
BAZEL_BUILDKITE  = --flaky_test_attempts=3 --build_tests_only --local_test_jobs=12 --show_progress_rate_limit=1 --curses=yes --color=yes --terminal_columns=143 --show_timestamps --verbose_failures --keep_going --jobs=32 --announce_rc --experimental_multi_threaded_digest --experimental_repository_cache_hardlinks --disk_cache= --sandbox_tmpfs_path=/tmp --experimental_build_event_json_file_path_conversion=false --build_event_json_file=/tmp/test_bep.json

BAZEL_BUILDKITE_BUILD = --show_progress_rate_limit=1 --curses=yes --color=yes --terminal_columns=143 --show_timestamps --verbose_failures --keep_going --jobs=32 --announce_rc --experimental_multi_threaded_digest --experimental_repository_cache_hardlinks --disk_cache= --sandbox_tmpfs_path=/tmp
BAZEL_REMOTE     = --remote_cache=http://bazelcache.default:8080

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

bazel-fetch: ## Generate BUILD.bazel files
	bazel fetch $(BAZEL_REPOSITORY)

bazel-deps-update: ## Update bazel dependencies based on Gopkg.lock
	bazel $(BAZEL_OUTPUT) run //:gazelle -- update-repos -from_file=go.mod

bazel-test: ## Test
	bazel test $(BAZEL_REPOSITORY) $(BAZEL_FLAGS) $(BAZEL_REMOTE) $(BAZEL_BUILDKITE) //pkg/...

bazel-dist: ## Build the project
	bazel $(BAZEL_OUTPUT) run --distdir=./distfiles2/ $(BAZEL_REPOSITORY) $(BAZEL_FLAGS) $(BAZEL_REMOTE) :additional_distfiles

bazel-sync:
	bazel sync $(BAZEL_REPOSITORY) --experimental_repository_cache_hardlinks --show_progress_rate_limit=5 --curses=yes --color=yes --terminal_columns=143 --show_timestamps --keep_going --announce_rc

bazel-build: ## Run the project inside docker
	bazel build $(BAZEL_REPOSITORY) $(BAZEL_FLAGS) $(BAZEL_REMOTE) $(BAZEL_BUILDKITE_BUILD) //cmd/graphql:docker

bazel-lint:
	bazel run $(BAZEL_REPOSITORY) $(BAZEL_FLAGS) $(BAZEL_REMOTE) $(BAZEL_BUILDKITE_BUILD) //:golangcilint
