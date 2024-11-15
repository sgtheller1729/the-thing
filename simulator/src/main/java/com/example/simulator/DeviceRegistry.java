package com.example.simulator;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Keeps track of devices for communication purposes.
 */
public class DeviceRegistry {

    private static ConcurrentMap<Integer, Device> deviceMap = new ConcurrentHashMap<>();

    /**
     * Registers a device.
     *
     * @param device The device to register.
     */
    public static void registerDevice(Device device) {
        deviceMap.put(device.getDeviceId(), device);
    }

    /**
     * Unregisters a device.
     *
     * @param deviceId The ID of the device to unregister.
     */
    public static void unregisterDevice(int deviceId) {
        deviceMap.remove(deviceId);
    }

    /**
     * Retrieves a device by its ID.
     *
     * @param deviceId The ID of the device.
     * @return The device, or null if not found.
     */
    public static Device getDevice(int deviceId) {
        return deviceMap.get(deviceId);
    }
}
