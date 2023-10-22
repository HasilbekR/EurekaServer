FROM gradle:7.2-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

# Use an OpenJDK image for the runtime stage
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/EurekaServer-0.0.1-SNAPSHOT.jar EurekaServer.jar
EXPOSE 8088
ENTRYPOINT ["java", "-jar", "EurekaServer.jar"]