# IoT Cloud Architecture Monorepo Phase Plan

## Phase 1: Basic MQTT Connection and Command Simulation

**Goal:**

Establish MQTT connectivity and simulate basic publish/subscribe commands.

**Tasks:**

1. Set up the `/app` directory and initialize the Go module:

     ```sh
     go mod init your_project_name
     ```

1. Implement basic MQTT publish/subscribe functionality:

    - Connect to a public MQTT broker (e.g., HiveMQ).
    - Publish a “dummy” command (e.g., “Engine Start”) to an MQTT topic.
    - Subscribe to the same topic to simulate receiving a response.

**Deliverable:**

A Go application that:

- Connects to an MQTT broker.
- Publishes a test command.
- Logs responses received via the subscribed topic.

**Validation:**

- Use an MQTT client like MQTT.fx or HiveMQ WebSocket to verify published messages.
- Ensure messages are logged when received.

## Phase 2: REST API to Trigger Commands

**Goal:**

Build a REST API endpoint to trigger MQTT commands dynamically.

**Tasks:**

1. Add a `/trigger-command` REST endpoint:

    - Accept input parameters like command, ivc, vin, etc.
    - Publish the command to MQTT upon receiving the request.

1. Use the `gorilla/mux` library for routing.
1. Validate input parameters before publishing.

**Deliverable:**

A REST endpoint that:

- Accepts a JSON payload.
- Publishes the specified command to MQTT.

**Validation:**

- Use Postman or curl to test the REST API.
- Verify that commands are published to MQTT and logged.

## Phase 3: Concurrent MQTT Connections

**Goal:**

Simulate multiple devices by managing up to 100 MQTT connections.

**Tasks:**

1. Refactor the MQTT code to handle multiple connections using goroutines.
1. Randomize the commands sent from each connection (e.g., “Engine Start/Stop”).
1. Log each connection’s actions and responses.

**Deliverable:**

A Go application that:

- Manages up to 100 concurrent MQTT connections.
- Sends randomized commands from each connection.

**Validation:**

- Verify all connections are active and publishing commands
- Check logs for responses received from MQTT.

## Phase 4: RabbitMQ Integration

**Goal:**

Add RabbitMQ for message acknowledgment and status tracking.

**Tasks:**

1. Set up a RabbitMQ sender to publish command statuses.
1. Implement a RabbitMQ listener to receive acknowledgments.
1. Integrate with the existing MQTT and REST logic:

    - When a command is triggered, publish its status to RabbitMQ.
    - Process acknowledgments and log results.

**Deliverable:**

A Go application that:

- Uses RabbitMQ to track and acknowledge commands.

**Validation:**

- Use the RabbitMQ Management Console to monitor queues.
- Verify that messages are published and acknowledged correctly.

## Phase 5: Database and Redis Integration

**Goal:**

Persist command data in a database and use Redis for caching frequently accessed data.

**Tasks:**

1. Set up a SQL database (e.g., PostgreSQL) to store command and device status.
1. Implement Redis caching for frequently accessed data (e.g., device status).
1. Refactor the REST API to read/write from the database.

**Deliverable:**

A Go application that:

- Persists commands in a database.
- Uses Redis for caching.

**Validation:**

- Verify that commands and statuses are correctly stored in the database.
- Test Redis cache hit/miss scenarios.

## Phase 6: Logging and Scheduling

**Goal:**

Improve observability and automate tasks.

**Tasks:**

1. Add structured logging using the `zap` library.
1. Implement a scheduler with the `cron` library to automate periodic tasks:

    - Example: Trigger a command every 5 minutes for testing.

1. Refactor the application to include detailed logging for key events.

**Deliverable:**

A Go application that:

- Logs all significant actions and errors.
- Automates tasks based on a schedule.

**Validation:**

- Review logs for clarity and completeness.
- Verify scheduled tasks are executed as expected.

## Phase 7: Code Quality and Unit Testing

**Goal:**

Ensure the application is robust and maintainable.

**Tasks:**

1. Write unit tests for each module:

    - MQTT publish/subscribe.
    - REST endpoints.
    - RabbitMQ messaging.
    - Database interactions.

1. Refactor the codebase to ensure modularity and readability.
1. Add comprehensive comments and documentation.

**Deliverable:**

A fully tested and documented Go application.

**Validation:**

- Achieve high test coverage.
- Run the application without issues in a development environment.

## Phase 8: Deployment to AWS EKS

**Goal:**

Deploy the application to an AWS EKS cluster.

**Tasks:**

1. Containerize the application using Docker.
1. Push the Docker image to an ECR repository.
1. Use your existing Terraform setup to deploy the application to EKS.

**Deliverable:**

The application is live on AWS EKS, ready for production use.

**Validation:**

- Access the application via its public endpoint.
- Test MQTT, REST, and RabbitMQ functionality in a live environment.

## Timeline and Priorities

| Phase  | Expected Duration |
|--------|-------------------|
| Phase 1 | 1-2 days          |
| Phase 2 | 1-2 days          |
| Phase 3 | 3-5 days          |
| Phase 4 | 3-5 days          |
| Phase 5 | 3-5 days          |
| Phase 6 | 2-3 days          |
| Phase 7 | 3-4 days          |
| Phase 8 | 2-3 days          |

This approach allows you to develop the application iteratively, ensuring that each component is well-tested and functional before moving on to the next. Let me know which phase you’d like more detailed guidance on!
