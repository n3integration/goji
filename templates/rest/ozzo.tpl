package main

import (
	"log"
	"net/http"

    "github.com/go-ozzo/ozzo-routing"
	"github.com/go-ozzo/ozzo-routing/access"
	"github.com/go-ozzo/ozzo-routing/content"
)

var addr = "{{ .Host }}:{{ .Port }}"

func main() {
	// Create new router
	r := routing.New()

	// Setup common middleware
	r.Use(
		access.Logger(log.Printf),
        content.TypeNegotiator(content.JSON),
	)

	// Register health endpoint
	r.Get("/health", health)

	// Now listening on: http://{{ .Host }}:{{ .Port }}
	// Application started. Press CTRL+C to shut down.
	http.Handle("/", r)
	http.ListenAndServe(addr, nil)
}

// Ozzo handler
func health(c *routing.Context) error {
	h := struct {
		Status string `json:"status"`
	} {
		Status: "OK",
	}
	return c.Write(h)
}