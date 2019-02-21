//go:generate go run ../../scripts/gqlgen.go -v

package graphql

import (
	context "context"

	"github.com/mishudark/errors"
	"github.com/mishudark/graphql-api/pkg/api"
	"github.com/mishudark/graphql-api/pkg/api/server"
)

// Resolver is the root gaphql resolver for graphl queries and mutations
type Resolver struct {
	Endpoints server.Endpoints
}

// Mutation returns a root resolver for graphql mutations
func (r *Resolver) Mutation() MutationResolver {
	return &mutationResolver{r}
}

// Query returns a root resolver for graphql queries
func (r *Resolver) Query() QueryResolver {
	return &queryResolver{r}
}

type mutationResolver struct{ *Resolver }

func (r *mutationResolver) CreateTask(ctx context.Context, input api.CreateTaskRequest) (api.Task, error) {
	res, err := r.Endpoints.CreateTask(ctx, input)

	task, ok := res.(api.Task)
	if !ok {
		return task, errors.E(errors.New("can't cast endpoint.CreateTask output to api.Task"), errors.Internal)
	}

	return task, err
}

type queryResolver struct{ *Resolver }

func (r *queryResolver) Todos(ctx context.Context) ([]api.Task, error) {
	res, err := r.Endpoints.ListTask(ctx, nil)

	tasks, ok := res.([]api.Task)
	if !ok {
		return tasks, errors.E(errors.New("can't cast endpoint.ListTask output to []api.Task"), errors.Internal)
	}

	return tasks, err
}
