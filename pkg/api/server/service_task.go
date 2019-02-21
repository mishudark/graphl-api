package server

import (
	"context"

	"github.com/mishudark/graphql-api/pkg/api"
)

type taskService struct{}

func (s *taskService) Create(ctx context.Context, req api.CreateTaskRequest) (api.Task, error) {
	task := api.Task{
		ID:   "1173daf0-eb67-4ac1-8c15-200fcdf12f7a",
		Text: "Create graphql skeleton",
		Done: false,
	}

	return task, nil
}

func (s *taskService) List(ctx context.Context) ([]api.Task, error) {
	tasks := []api.Task{
		{
			ID:   "1173daf0-eb67-4ac1-8c15-200fcdf12f7a",
			Text: "Create graphql skeleton",
			Done: false,
		},
	}

	return tasks, nil
}

// NewTaskService returns an api.TaskService
func NewTaskService() api.TaskService {
	return &taskService{}
}
