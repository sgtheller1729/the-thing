# Use a Maven image to build the application
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight JRE image to run the application
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/iot-app.jar ./iot-app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "iot-app.jar"]
