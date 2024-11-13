package com.example.iotapp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import javax.annotation.PreDestroy;

@Configuration
public class ServiceManager {

    @Bean
    public void startServices() {
        // Start the MQTT broker
        startBroker();

        // Start the web server
        startWebServer();
    }

    private void startBroker() {
        // Logic to start the MQTT broker
        System.out.println("Starting MQTT broker...");
        // Add your broker start logic here
    }

    private void startWebServer() {
        // Logic to start the web server
        System.out.println("Starting web server...");
        // Add your web server start logic here
    }

    @PreDestroy
    public void stopServices() {
        // Logic to stop the MQTT broker
        System.out.println("Stopping MQTT broker...");
        // Add your broker stop logic here

        // Logic to stop the web server
        System.out.println("Stopping web server...");
        // Add your web server stop logic here
    }
}
