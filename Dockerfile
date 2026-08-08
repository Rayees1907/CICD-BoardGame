FROM maven:3.9-eclipse-temurin-11 AS builder

WORKDIR /app

COPY pom.xml /app/

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

# 2nd Stage

FROM eclipse-temurin:11-jre 

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]