package main

import (
	"log"
	"broker/broker"
	"broker/webserver"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	// Initialize shared activity map for the webserver
	webserver.Init(&broker.ActivityMap)

	// Start the broker and web server in goroutines
	go broker.StartBroker()
	go webserver.StartWebServer()

	// Handle termination signals
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	<-sigs
	log.Println("Shutting down services...")

	// Stop the broker and web server
	broker.StopBroker()
	webserver.StopWebServer()

	log.Println("All services stopped.")
}