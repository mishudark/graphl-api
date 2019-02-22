package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/99designs/gqlgen/handler"
	"github.com/mishudark/graphql-api/pkg/api/server"
	"github.com/mishudark/graphql-api/pkg/graphql"
	"github.com/mishudark/graphql-api/pkg/health"
	"github.com/mishudark/graphql-api/pkg/metrics"
)

const defaultPort = "8000"

func main() {
	log.Printf("Initialize GraphQL service...")

	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = defaultPort
	}

	var endpoints server.Endpoints
	{
		services := server.Services{
			Task: server.NewTaskService(),
		}

		endpoints = server.MakeEndpoints(services)
		server.InstrumentEndpoints(&endpoints)
	}

	resolver := graphql.Resolver{
		Endpoints: endpoints,
	}

	pe := metrics.NewPrometheusExporter("graphql")

	http.Handle("/", handler.Playground("GraphQL playground", "/query"))
	http.Handle("/query", handler.GraphQL(graphql.NewExecutableSchema(graphql.Config{Resolvers: &resolver})))
	http.Handle("/health", health.Handler())
	http.Handle("/metrics", pe)

	server := &http.Server{
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 5 * time.Second,
		Addr:         fmt.Sprintf(":%s", port),
	}

	errs := make(chan error, 2)
	go func() {
		errs <- server.ListenAndServe()
	}()

	go func() {
		c := make(chan os.Signal, 1)
		signal.Notify(c, syscall.SIGINT)
		errs <- fmt.Errorf("%s", <-c)
	}()

	log.Printf("open http://localhost:%s for GraphQL playground\n", port)
	log.Println("terminated", <-errs)
}
