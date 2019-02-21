package api

import "context"

// CreateTaskRequest is used to save a new Task
type CreateTaskRequest struct {
	Text string `json:"text"`
}

// Task represents a todo with a "done" flag
type Task struct {
	ID   string `json:"id"`
	Text string `json:"text"`
	Done bool   `json:"done"`
}

// TaskService contains the methods for implement the logic behind a todolist
type TaskService interface {
	Create(ctx context.Context, req CreateTaskRequest) (Task, error)
	List(ctx context.Context) ([]Task, error)
}
