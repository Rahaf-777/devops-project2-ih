# ===============================
# Stage 1: Build the application
# ===============================
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ===============================
# Stage 2: Run the application
# ===============================
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/burger-builder-backend-1.0.0.jar app.jar

EXPOSE 8080

ENV SPRING_DATASOURCE_URL="jdbc:sqlserver://sqlserver-rahaf-dev.database.windows.net:1433;database=sqldb-rahaf-dev;encrypt=true;trustServerCertificate=false;loginTimeout=30;"
ENV SPRING_DATASOURCE_USERNAME="sqladminuser@sqlserver-rahaf-dev"
ENV SPRING_DATASOURCE_PASSWORD="!StrongP@ssword123"

ENTRYPOINT ["java", "-jar", "app.jar"]

