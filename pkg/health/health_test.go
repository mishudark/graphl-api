package health

import (
	"log"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthHandler(t *testing.T) {
	t.Parallel()
	ts := httptest.NewServer(Handler())
	defer ts.Close()

	res, err := http.Get(ts.URL)
	if err != nil {
		log.Fatal(err)
	}

	if res.StatusCode != 200 {
		t.Errorf("expected status code: 200, got: %d", res.StatusCode)
	}
}
