package com.example.simulator;

import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * Represents a simulated device that sends commands and receives responses.
 */
public class Device implements Runnable {

    private final int deviceId;
    private final Broker broker;
    private volatile boolean running;
    private final Random random;

    public Device(int deviceId, Broker broker) {
        this.deviceId = deviceId;
        this.broker = broker;
        this.running = true;
        this.random = new Random();
        // Register this device
        DeviceRegistry.registerDevice(this);
    }

    public int getDeviceId() {
        return deviceId;
    }

    /**
     * Stops the device's operation.
     */
    public void stopDevice() {
        running = false;
        // Unregister device
        DeviceRegistry.unregisterDevice(deviceId);
    }

    /**
     * Receives a response from the broker.
     *
     * @param response The response received.
     */
    public void receiveResponse(Response response) {
        // Process the response
        System.out.println("Device " + deviceId + " received response: " + response.getResponseText());
    }

    @Override
    public void run() {
        System.out.println("Device " + deviceId + " started.");
        while (running) {
            // Simulate sending commands at random intervals
            try {
                // Sleep for a random duration between 0 to 4 seconds
                int sleepTime = random.nextInt(5);
                TimeUnit.SECONDS.sleep(sleepTime);

                // Send a random command
                String[] commands = {"Engine Start", "Engine Stop", "Door Lock", "Door Unlock", "AC On", "AC Off"};
                String commandText = commands[random.nextInt(commands.length)];
                Command command = new Command(deviceId, commandText);
                broker.receiveCommand(command);
                System.out.println("Device " + deviceId + " sent command: " + commandText);

            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                System.out.println("Device " + deviceId + " interrupted.");
            }
        }
        System.out.println("Device " + deviceId + " stopped.");
    }
}
