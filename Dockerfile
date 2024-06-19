# Dicker file

FROM openjdk:17-jdk-alpine
VOLUME /tmp
ADD target/spring-boot-security-jwt-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

