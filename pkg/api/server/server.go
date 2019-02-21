package server

import (
	"github.com/go-kit/kit/endpoint"
	"github.com/mishudark/graphql-api/pkg/api"
	md "github.com/mishudark/graphql-api/pkg/middleware"
)

// Endpoints contains all available endpoints for this api
type Endpoints struct {
	CreateTask endpoint.Endpoint
	ListTask   endpoint.Endpoint
}

// Services contains all available services in this api
type Services struct {
	Task api.TaskService
}

// MakeEndpoints initialize endpoints using the given service
func MakeEndpoints(s Services) Endpoints {
	return Endpoints{
		CreateTask: makeCreateTaskEndpoint(s.Task),
		ListTask:   makeListTaskEndpoint(s.Task),
	}
}

// InstrumentEndpoints adds the metric middleware to every endpoint
func InstrumentEndpoints(e *Endpoints) {
	e.CreateTask = md.Metrics(e.CreateTask, "createTastk")
	e.ListTask = md.Metrics(e.ListTask, "listTask")
}
