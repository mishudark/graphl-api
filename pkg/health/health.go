package health

import (
	"net/http"
)

// Handler returns an http.Handler with status code 200
func Handler() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	}
}
