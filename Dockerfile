# Build stage
FROM gradle:7.2-jdk17 AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src

# To help diagnose issues, you can add these lines
RUN gradle --version
RUN ls -l  # List files to make sure your project structure is as expected
RUN gradle build --stacktrace  # Build your project with stack trace output

# Runtime stage
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /home/gradle/src/build/libs/EurekaServer-0.0.1-SNAPSHOT.jar /EurekaServer.jar
EXPOSE 8088
ENTRYPOINT ["java", "-jar", "EurekaServer.jar"]