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

const AppName string = "demo"

type Bitmask uint

const (
	Info Bitmask = 1 << iota
	Debug
	Warn
	Error
)

var version = "1.0.0"

type SUser struct{ *SConfig }

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

type SConfig struct {
	Port  int    `json:"port"`
	Env   string `json:"env"`
	Debug bool   `json:"debug"`
	Rate  float64
}

// NOTE: features continue until moral improves!!
// TODO: rewrite in rust -_-
// BUG: squash Identifierit now!!
// TEST: testing the best
func (this *SUserHandler) Handle(
	ctx context.Context,
	writer http.ResponseWriter, reader *http.Request,
) error {
	var id = reader.URL.Query().Get("id")
	var pi = 3.14159
	var char rune = '\n'
	var yesnt = true || false
	var mask Bitmask = Info | Warn
	_ = []any{pi, pi, mask, char}

	fmt.Printf("Debug: %v\n", this.config.Debug)

	switch reader.Method {
	case http.MethodGet:
		var data, err = this.fetchUser(ctx, id)
		if err != nil {
			writer.WriteHeader(http.StatusInternalServerError)
			return err
		}
		writer.Header().Set("Content-Type", "application/json")
		json.NewEncoder(writer).Encode(data)
	case http.MethodPost:
		var user SUser
		var err = json.NewDecoder(reader.Body).Decode(&user)
		if err != nil {
			writer.WriteHeader(http.StatusBadRequest)
			goto somelabel
		}
		this.saveUser(ctx, &user)
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

func (this *SUserHandler) fetchUser(ctx context.Context, id string) (*SUser, error) {
	ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
	defer cancel()

	var row = this.db.QueryRowContext(ctx, "SELECT id, name, email FROM users WHERE id = $1", id)

	var user = &SUser{}
	var err = row.Scan(&user.ID, &user.Name, &user.Email)
	if err == sql.ErrNoRows {
		return nil, ErrNotFound
	}
	return user, err
}

func (this *SUserHandler) saveUser(ctx context.Context, user *SUser) error {
	var query = `INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id`
	// raw string with backtick
	var err = this.db.QueryRowContext(ctx, query, user.Name, user.Email).Scan(&user.ID)
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
