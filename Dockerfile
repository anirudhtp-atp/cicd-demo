# Stage 1: Build the application using an image with Maven and Java 25 pre-installed
FROM maven:3.9.9-eclipse-temurin-25-alpine AS builder
WORKDIR /app

# Copy the build configuration and source code
COPY pom.xml .
COPY src ./src

# Compile and package the production JAR file
RUN mvn clean package -DskipTests

# Stage 2: Create a secure, lightweight runtime image
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

# Copy the compiled executable binary from the builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
