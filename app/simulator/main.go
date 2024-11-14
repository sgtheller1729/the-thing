package main

import (
	"log"
	"math/rand"
	"os"
	"os/signal"
	"strconv"
	"sync"
	"syscall"
	"time"

	mqtt "github.com/eclipse/paho.mqtt.golang"
)

const (
	brokerURL     = "tcp://localhost:1883" // Local MQTT broker
	commandTopic  = "devices/commands"
	responseTopic = "devices/responses"
	numDevices    = 100
)

var (
	rng = rand.New(rand.NewSource(time.Now().UnixNano()))
)

// Simulated actions based on responses
func performAction(action string) {
	log.Printf("Performing simulated action: %s", action)
}

// Publish a random command to the MQTT broker
func publishCommand(client mqtt.Client, deviceID int) {
	commands := []string{"Engine Start", "Engine Stop", "Door Lock", "Door Unlock", "AC On", "AC Off"}
	command := commands[rng.Intn(len(commands))]
	token := client.Publish(commandTopic, 0, false, command)
	token.Wait()
	if token.Error() != nil {
		log.Printf("Device %d: Error publishing command: %v", deviceID, token.Error())
	} else {
		log.Printf("Device %d: Published command: %s", deviceID, command)
	}
}

// Callback for received responses
func onMessageReceived(client mqtt.Client, msg mqtt.Message) {
	// log.Printf("Simulator received response: %s", string(msg.Payload()))
	// performAction(string(msg.Payload()))
}

// Connect and simulate a single device
func connectAndSimulate(id int, wg *sync.WaitGroup, stopChan chan struct{}) {
	defer wg.Done()

	// Configure MQTT client options
	opts := mqtt.NewClientOptions().
		AddBroker(brokerURL).
		SetClientID("device-" + strconv.Itoa(id)).
		SetDefaultPublishHandler(onMessageReceived)

	client := mqtt.NewClient(opts)
	if token := client.Connect(); token.Wait() && token.Error() != nil {
		log.Printf("Device %d failed to connect: %v", id, token.Error())
		return
	}
	defer client.Disconnect(250)

	log.Printf("Device %d connected", id)

	// Subscribe to the response topic
	if token := client.Subscribe(responseTopic, 0, nil); token.Wait() && token.Error() != nil {
		log.Printf("Device %d failed to subscribe: %v", id, token.Error())
		return
	}

	// Simulate randomized publishing of commands
	for {
		select {
		case <-stopChan:
			log.Printf("Device %d stopping simulation", id)
			return
		default:
			publishCommand(client, id)
			time.Sleep(time.Duration(rand.Intn(5)) * time.Second)
		}
	}
}

func main() {
	// Handle graceful shutdown
	sigs := make(chan os.Signal, 1)
	stopChan := make(chan struct{})
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	// Wait group for goroutines
	var wg sync.WaitGroup

	// Start multiple device simulations
	for i := 0; i < numDevices; i++ {
		wg.Add(1)
		go connectAndSimulate(i, &wg, stopChan)
	}

	// Wait for shutdown signal
	<-sigs
	log.Println("Shutting down simulator...")
	close(stopChan)

	// Wait for all goroutines to complete
	wg.Wait()
	log.Println("Simulator stopped gracefully")
}
