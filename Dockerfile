# ==============================
# Stage 1: Build the application
# ==============================
FROM maven:3.9.6-eclipse-temurin-21 AS builder

# Set working directory inside container
WORKDIR /app

# Copy pom.xml and download dependencies first (to leverage Docker cache)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy project files and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# ==============================
# Stage 2: Create runtime image
# ==============================
FROM eclipse-temurin:21-jre

# Set working directory
WORKDIR /app

# Copy the built jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose application port (change if your app runs on a different port)
EXPOSE 8080

# Set the startup command
ENTRYPOINT ["java", "-jar", "app.jar"]
