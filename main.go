package main

import (
	"fmt"
	"net/http"

	"github.com/sei-shigeo/docker-go-myapp/views"
)

func Home(w http.ResponseWriter, r *http.Request) {
	views.Home().Render(r.Context(), w)
}

func About(w http.ResponseWriter, r *http.Request) {
	views.About().Render(r.Context(), w)
}

func Contact(w http.ResponseWriter, r *http.Request) {
	views.Contact().Render(r.Context(), w)
}

func Signup(w http.ResponseWriter, r *http.Request) {
	views.Signup().Render(r.Context(), w)
}

func Login(w http.ResponseWriter, r *http.Request) {
	views.Login().Render(r.Context(), w)
}

func main() {
	mux := http.NewServeMux()
	mux.Handle("/assets/", http.StripPrefix("/assets/", http.FileServer(http.Dir("./assets"))))

	mux.HandleFunc("/", Home)
	mux.HandleFunc("/about", About)
	mux.HandleFunc("/contact", Contact)
	mux.HandleFunc("/signup", Signup)
	mux.HandleFunc("/login", Login)

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
