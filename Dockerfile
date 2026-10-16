# Stage 1: Build the application using the official Debian/Ubuntu-based Maven image for JDK 25
FROM maven:3.9.9-eclipse-temurin-25 AS builder
WORKDIR /app

# Copy the build configuration and source code
COPY pom.xml .
COPY src ./src

# Compile and package the production JAR file
RUN mvn clean package -DskipTests

# Stage 2: Create a secure, lightweight runtime image using Alpine for Java 25
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

# Copy the compiled executable binary from the builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
