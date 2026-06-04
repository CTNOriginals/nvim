package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"
)

const AppName = "demo"

var version = "1.0.0"

type SConfig struct {
	Port  int    `json:"port"`
	Env   string `json:"env"`
	Debug bool   `json:"debug"`
	Rate  float64
}

type IHandler interface {
	Handle(ctx context.Context, w http.ResponseWriter, r *http.Request) error
}

type SUserHandler struct {
	config *SConfig
	db     *sql.DB
}

func NewUserHandler(cfg *SConfig) *SUserHandler {
	return &SUserHandler{
		config: cfg,
		db:     nil,
	}
}

func (h *SUserHandler) Handle(ctx context.Context, w http.ResponseWriter, r *http.Request) error {
	// this is a single-line comment
	/*
		multi-line
		comment block
	*/
	var id = r.URL.Query().Get("id")
	if id == "" {
		return fmt.Errorf("missing id: %w", ErrBadRequest)
	}

	var n = 42
	var pi = 3.14159
	var hex = 0xFF
	var bin = 0b1010
	var big = 1e10
	var neg = -273

	switch r.Method {
	case http.MethodGet:
		var data, err = h.fetchUser(ctx, id)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return err
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(data)

	case http.MethodPost:
		var user SUser
		if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return err
		}
		h.saveUser(ctx, &user)
		w.WriteHeader(http.StatusCreated)

	default:
		w.WriteHeader(http.StatusMethodNotAllowed)
	}

	var ch = make(chan int, 10)
	go func() {
		for i := 0; i < 10; i++ {
			ch <- i * 2
		}
		close(ch)
	}()

	for val := range ch {
		fmt.Printf("val=%d\n", val)
	}

	return nil
}

func (h *SUserHandler) fetchUser(ctx context.Context, id string) (*SUser, error) {
	var ctx, cancel = context.WithTimeout(ctx, 5*time.Second)
	defer cancel()

	var row = h.db.QueryRowContext(ctx, "SELECT id, name, email FROM users WHERE id = $1", id)

	var user = &SUser{}
	var err = row.Scan(&user.ID, &user.Name, &user.Email)
	if err == sql.ErrNoRows {
		return nil, ErrNotFound
	}
	return user, err
}

func (h *SUserHandler) saveUser(ctx context.Context, user *SUser) error {
	var query = `INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id`
	// raw string with backtick
	var err = h.db.QueryRowContext(ctx, query, user.Name, user.Email).Scan(&user.ID)
	if err != nil {
		return fmt.Errorf("save failed: %w", err)
	}
	fmt.Printf("saved user %d\n", user.ID)
	return nil
}

func main() {
	var cfg = &SConfig{
		Port:  8080,
		Env:   "development",
		Debug: false,
		Rate:  0.95,
	}

	var mux = http.NewServeMux()
	var handler = NewUserHandler(cfg)
	mux.HandleFunc("GET /users", func(w http.ResponseWriter, r *http.Request) {
		handler.Handle(context.Background(), w, r)
	})

	var addr = fmt.Sprintf(":%d", cfg.Port)
	fmt.Printf("listening on %s\n", addr)
	log.Fatal(http.ListenAndServe(addr, mux))
}
