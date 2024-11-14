package broker

import (
	"log"
	"sync"

	mqtt "github.com/mochi-mqtt/server/v2"
	"github.com/mochi-mqtt/server/v2/hooks/auth"
	"github.com/mochi-mqtt/server/v2/listeners"
	"github.com/mochi-mqtt/server/v2/packets"
)

var ActivityMap sync.Map

type CustomHook struct {
	mqtt.HookBase
	Server *mqtt.Server
}

func (h *CustomHook) Init(config any) error {
	if server, ok := config.(*mqtt.Server); ok {
		h.Server = server
		return nil
	}
	return mqtt.ErrInvalidConfigType
}

func (h *CustomHook) Provides(b byte) bool {
	return b == mqtt.OnConnect || b == mqtt.OnDisconnect || b == mqtt.OnPublish || b == mqtt.OnPublished
}

func (h *CustomHook) OnConnect(client *mqtt.Client, pk packets.Packet) error {
	log.Printf("Client connected: %s", client.ID)
	return nil
}

func (h *CustomHook) OnDisconnect(client *mqtt.Client, err error, expire bool) {
	if err != nil {
		log.Printf("Client disconnected: %s, Error: %v", client.ID, err)
	} else {
		log.Printf("Client disconnected: %s", client.ID)
	}
}

func (h *CustomHook) OnPublish(client *mqtt.Client, pk packets.Packet) (packets.Packet, error) {
	log.Printf("Broker received: client='%s', topic='%s', payload='%s'",
		client.ID, pk.TopicName, string(pk.Payload))

	ActivityMap.Store(client.ID, string(pk.Payload))

	if pk.TopicName == "devices/commands" {
		responseTopic := "devices/responses"
		responsePayload := []byte("Acknowledged: " + string(pk.Payload))

		err := h.Server.Publish(responseTopic, responsePayload, false, 0)
		if err != nil {
			log.Printf("Error publishing response to '%s': %v", responseTopic, err)
		} else {
			log.Printf("Published response to topic '%s': %s", responseTopic, string(responsePayload))
		}
	}

	return pk, nil
}

func (h *CustomHook) OnPublished(client *mqtt.Client, pk packets.Packet) {
	log.Printf("Message published to topic='%s', payload='%s'", pk.TopicName, string(pk.Payload))
}

var server *mqtt.Server

// StartBroker starts the MQTT broker in a goroutine
func StartBroker() {
	server = mqtt.New(&mqtt.Options{InlineClient: true})

	// Add hooks
	_ = server.AddHook(new(auth.AllowHook), nil)
	err := server.AddHook(&CustomHook{}, server)
	if err != nil {
		log.Fatalf("Failed to add custom hook: %v", err)
	}

	// Add a TCP listener
	tcp := listeners.NewTCP(listeners.Config{
		ID:      "local_mqtt",
		Address: ":1883",
	})
	if err := server.AddListener(tcp); err != nil {
		log.Fatalf("Failed to add listener: %v", err)
	}

	go func() {
		log.Println("Local MQTT broker running on port 1883...")
		if err := server.Serve(); err != nil {
			log.Fatalf("MQTT broker failed: %v", err)
		}
	}()
}

// StopBroker stops the MQTT broker gracefully
func StopBroker() {
	if server != nil {
		log.Println("Shutting down MQTT broker...")
		server.Close()
		log.Println("MQTT broker stopped gracefully")
	}
}
