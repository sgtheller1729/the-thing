package com.example.simulator;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * Manages the simulation of devices.
 */
public class SimulationManager {

    private static final int NUM_DEVICES = 100;

    private final Broker broker;
    private final List<Device> devices;
    private final ExecutorService executorService;

    public SimulationManager() {
        this.broker = new Broker();
        this.devices = new ArrayList<>();
        this.executorService = Executors.newFixedThreadPool(NUM_DEVICES);
    }

    /**
     * Starts the simulation by creating and running device threads.
     */
    public void startSimulation() {
        // Create and start devices
        for (int i = 0; i < NUM_DEVICES; i++) {
            Device device = new Device(i, broker);
            devices.add(device);
            executorService.submit(device);
        }

        // Add shutdown hook to gracefully stop the simulation
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.out.println("Shutting down simulation...");
            stopSimulation();
            System.out.println("Simulation stopped.");
        }));
    }

    /**
     * Stops the simulation by stopping all devices and shutting down the executor.
     */
    public void stopSimulation() {
        // Stop all devices
        for (Device device : devices) {
            device.stopDevice();
        }
        // Shutdown executor service
        executorService.shutdownNow();
        try {
            if (!executorService.awaitTermination(5, TimeUnit.SECONDS)) {
                System.err.println("Executor did not terminate in the specified time.");
            }
        } catch (InterruptedException e) {
            System.err.println("Termination interrupted.");
        }
    }
}
