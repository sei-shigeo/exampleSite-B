package main

import (
	"fmt"
	"net/http"

	"github.com/sei-shigeo/docker-go-myapp/views"
)

func greet(w http.ResponseWriter, r *http.Request) {
	views.Home().Render(r.Context(), w)
}

func main() {
	mux := http.NewServeMux()
	mux.Handle("/assets/", http.StripPrefix("/assets/", http.FileServer(http.Dir("./assets"))))

	mux.HandleFunc("/", greet)

	server := &http.Server{
		Addr:    ":8080",
		Handler: mux,
	}

	fmt.Println("Server is running on port 8080")
	err := server.ListenAndServe()
	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}
