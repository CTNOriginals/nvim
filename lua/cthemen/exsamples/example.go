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
	id := r.URL.Query().Get("id")
	if id == "" {
		return fmt.Errorf("missing id: %w", ErrBadRequest)
	}

	n := 42
	pi := 3.14159
	hex := 0xFF
	bin := 0b1010
	big := 1e10
	neg := -273

	switch r.Method {
	case http.MethodGet:
		data, err := h.fetchUser(ctx, id)
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

	ch := make(chan int, 10)
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
	ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
	defer cancel()

	row := h.db.QueryRowContext(ctx, "SELECT id, name, email FROM users WHERE id = $1", id)

	user := &SUser{}
	err := row.Scan(&user.ID, &user.Name, &user.Email)
	if err == sql.ErrNoRows {
		return nil, ErrNotFound
	}
	return user, err
}

func (h *SUserHandler) saveUser(ctx context.Context, user *SUser) error {
	query := `INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id`
	// raw string with backtick
	err := h.db.QueryRowContext(ctx, query, user.Name, user.Email).Scan(&user.ID)
	if err != nil {
		return fmt.Errorf("save failed: %w", err)
	}
	fmt.Printf("saved user %d\n", user.ID)
	return nil
}

func main() {
	cfg := &SConfig{
		Port:  8080,
		Env:   "development",
		Debug: false,
		Rate:  0.95,
	}

	mux := http.NewServeMux()
	handler := NewUserHandler(cfg)
	mux.HandleFunc("GET /users", func(w http.ResponseWriter, r *http.Request) {
		handler.Handle(context.Background(), w, r)
	})

	addr := fmt.Sprintf(":%d", cfg.Port)
	fmt.Printf("listening on %s\n", addr)
	log.Fatal(http.ListenAndServe(addr, mux))
}
