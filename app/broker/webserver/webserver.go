package webserver

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"path/filepath"
	"sync"
	"time"

	"github.com/gorilla/websocket"
)

var activityMap *sync.Map

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}

var server *http.Server

func Init(activityMapRef *sync.Map) {
	activityMap = activityMapRef
}

func getActivityHandler(w http.ResponseWriter, r *http.Request) {
	activities := make(map[string]string)
	activityMap.Range(func(key, value interface{}) bool {
		activities[key.(string)] = value.(string)
		return true
	})
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(activities)
}

func wsHandler(w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("WebSocket upgrade error:", err)
		return
	}
	defer conn.Close()

	// Channel to signal updates
	updateChan := make(chan map[string]string)

	// Goroutine to monitor activityMap for changes
	go func() {
		// Create a snapshot of the initial state
		lastState := make(map[string]string)
		for {
			currentState := make(map[string]string)
			activityMap.Range(func(key, value interface{}) bool {
				currentState[key.(string)] = value.(string)
				return true
			})

			// Compare current state with the last state
			if !mapsEqual(currentState, lastState) {
				lastState = currentState // Update last state
				updateChan <- currentState
			}

			time.Sleep(1 * time.Second) // Polling interval
		}
	}()

	// WebSocket send loop
	for {
		select {
		case activities := <-updateChan:
			err := conn.WriteJSON(activities)
			if err != nil {
				log.Println("WebSocket write error:", err)
				return
			}
		case <-time.After(30 * time.Second):
			// Send a ping to keep the connection alive
			err := conn.WriteControl(websocket.PingMessage, []byte{}, time.Now().Add(time.Second))
			if err != nil {
				log.Println("WebSocket ping error:", err)
				return
			}
		}
	}
}

// Helper function to compare two maps
func mapsEqual(a, b map[string]string) bool {
	if len(a) != len(b) {
		return false
	}
	for key, value := range a {
		if b[key] != value {
			return false
		}
	}
	return true
}

// StartWebServer starts the HTTP server and sets up routes.
func StartWebServer() {
	mux := http.NewServeMux()

	// Serve static files from the "static" directory
	fs := http.FileServer(http.Dir(filepath.Join("static")))
	mux.Handle("/", fs)

	// API routes
	mux.HandleFunc("/activity", getActivityHandler)
	mux.HandleFunc("/ws", wsHandler)

	server = &http.Server{
		Addr:    ":8080",
		Handler: mux,
	}

	go func() {
		log.Println("Web server running on :8080")
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Web server failed: %v", err)
		}
	}()
}

// StopWebServer shuts down the HTTP server gracefully.
func StopWebServer() {
	if server != nil {
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		if err := server.Shutdown(ctx); err != nil {
			log.Printf("Web server shutdown error: %v", err)
		} else {
			log.Println("Web server stopped gracefully")
		}
	}
}
