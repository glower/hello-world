package main

import (
	"log"
	"net/http"

	"github.com/glower/helloworld/backend/handler"
)

func main() {
	log.Println("Application is running")

	// serve backend service on :8080
	log.Println("Backend server started on http://localhost:8080")
	http.HandleFunc("/api/data", handler.GetDataHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
