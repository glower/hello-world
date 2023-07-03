package handler

import (
	"encoding/json"
	"log"
	"net/http"
)

const message = "Hello, World 1!"

// ResponseData represents the structure of the response data
type ResponseData struct {
	Message string `json:"message"`
}

// GetDataHandler returns a "Hello World" message.
func GetDataHandler(w http.ResponseWriter, r *http.Request) {
	// log request
	log.Printf("GET %q\n", r.URL.Path)

	// Create a response data object
	response := ResponseData{
		Message: message,
	}

	// Set the Content-Type header to application/json
	w.Header().Set("Content-Type", "application/json")
	// Set the Access-Control-Allow-Origin header to allow access from JS
	w.Header().Set("Access-Control-Allow-Origin", "*")

	// Set 200 OK status
	w.WriteHeader(http.StatusOK)

	// Encode the response data as JSON and write it to the response
	if err := json.NewEncoder(w).Encode(response); err != nil {
		log.Printf("Error encoding JSON: %s", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
