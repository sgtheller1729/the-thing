package com.example.simulator;

/**
 * Represents a response sent by the broker to a device.
 */
public class Response {

    private final int deviceId;
    private final String responseText;

    public Response(int deviceId, String responseText) {
        this.deviceId = deviceId;
        this.responseText = responseText;
    }

    public int getDeviceId() {
        return deviceId;
    }

    public String getResponseText() {
        return responseText;
    }
}
