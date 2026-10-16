# Stage 1: Build the application
FROM eclipse-temurin:25-jdk-alpine AS builder
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests || mvn clean package -DskipTests

# Stage 2: Create the lightweight runtime image
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app
# Copies the compiled jar file from the builder stage
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
