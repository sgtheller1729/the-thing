package com.example.iotapp.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CommandController {

    @PostMapping("/trigger-command")
    public String triggerCommand(@RequestBody String command) {
        // Logic to publish command to MQTT
        return "Command triggered: " + command;
    }
}
