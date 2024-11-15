package com.example.simulator;

/**
 * Simulates a broker that processes commands and sends responses.
 */
public class Broker {

    public Broker() {
        // Initialization if needed
    }

    /**
     * Receives a command from a device.
     *
     * @param command The command received.
     */
    public void receiveCommand(Command command) {
        // Process the command and generate a response
        System.out.println("Broker received command from Device " + command.getDeviceId() + ": " + command.getCommandText());

        // Simulate processing delay
        try {
            Thread.sleep(500); // 500 milliseconds
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        // Create a response
        String responseText = "Acknowledged command: " + command.getCommandText();
        Response response = new Response(command.getDeviceId(), responseText);
        sendResponse(response);
    }

    /**
     * Sends a response to a device.
     *
     * @param response The response to send.
     */
    public void sendResponse(Response response) {
        // Deliver the response to the device
        Device device = DeviceRegistry.getDevice(response.getDeviceId());
        if (device != null) {
            device.receiveResponse(response);
        } else {
            System.out.println("Device " + response.getDeviceId() + " not found.");
        }
    }
}
