package server

import (
	"context"

	"github.com/go-kit/kit/endpoint"
	"github.com/mishudark/errors"
	"github.com/mishudark/graphql-api/pkg/api"
)

func makeCreateTaskEndpoint(s api.TaskService) endpoint.Endpoint {
	return func(ctx context.Context, request interface{}) (interface{}, error) {
		payload, ok := request.(api.CreateTaskRequest)
		if !ok {
			return nil, errors.E(errors.New("can't cast makeCreateTask request to api.CreateTaskRequest"), errors.Internal)
		}

		return s.Create(ctx, payload)
	}
}

func makeListTaskEndpoint(s api.TaskService) endpoint.Endpoint {
	return func(ctx context.Context, request interface{}) (interface{}, error) {
		return s.List(ctx)
	}
}
