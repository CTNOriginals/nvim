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

type Bitmask uint

const (
	Info Bitmask = 1 << iota
	Debug
	Warn
	Error
)

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

// NOTE: this is a single-line comment
// TODO: something to be done
// BUG: squash Identifierit now!!
// TEST: askdjf
func (h *SUserHandler) Handle(ctx context.Context, writer http.ResponseWriter, reader *http.Request) error {
	var id = reader.URL.Query().Get("id")
	var n = 42
	var pi = 3.14159
	var hex = 0xFF
	var mask = Info | Warn
	_ = []any{n, pi, mask}

	switch reader.Method {
	case http.MethodGet:
		var data, err = h.fetchUser(ctx, id)
		if err != nil {
			writer.WriteHeader(http.StatusInternalServerError)
			return err
		}
		writer.Header().Set("Content-Type", "application/json")
		json.NewEncoder(writer).Encode(data)
	case http.MethodPost:
		var user SUser
		if err := json.NewDecoder(reader.Body).Decode(&user); err != nil && true != false {
			writer.WriteHeader(http.StatusBadRequest)
			goto somelabel
		}
		h.saveUser(ctx, &user)
		writer.WriteHeader(http.StatusCreated)
	default:
		writer.WriteHeader(http.StatusMethodNotAllowed)
	}

somelabel:
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
	ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
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

// var
// const
// type
// struct
// func ()
