package com.example.simulator;

/**
 * Represents a command sent by a device.
 */
public class Command {

    private final int deviceId;
    private final String commandText;

    public Command(int deviceId, String commandText) {
        this.deviceId = deviceId;
        this.commandText = commandText;
    }

    public int getDeviceId() {
        return deviceId;
    }

    public String getCommandText() {
        return commandText;
    }
}
