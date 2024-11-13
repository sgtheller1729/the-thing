# Use the official OpenJDK image as a base
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the jar file from the target directory (make sure to build your Spring Boot app first)
# Replace 'your-app.jar' with the name of your generated jar file
COPY target/your-app.jar app.jar

# Expose the application port (Spring Boot typically uses port 8080 by default)
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
