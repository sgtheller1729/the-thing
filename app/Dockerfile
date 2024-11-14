# syntax=docker/dockerfile:1

FROM golang:1.23.2

# Set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files to download dependencies
COPY broker/go.mod broker/go.sum ./
RUN go mod download

# Copy the entire broker directory to the working directory
COPY broker/ ./

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -o /broker-app ./main.go

# Expose the application port
EXPOSE 8080
EXPOSE 1883

# Define the default command to run the application
CMD ["/broker-app"]