run: ## Run the project
	GO111MODULE=on go run ./cmd/graphql

test: ## Run tests under pkg directory
	GO111MODULE=on go test ./pkg/...
