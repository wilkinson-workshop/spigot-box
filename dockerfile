FROM alpine:latest

EXPOSE 25565 25575
ARG JAVA_PACKAGE=openjdk17
ARG SPIGOT_BUILD_TOOLS_URL=https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
ARG MINECRAFT_VERSION=1.19.2
ENV MINECRAFT_RAM_INI=2048G
ENV MINECRAFT_RAM_MAX=2048G

# Get base dependencies.
RUN apk add $JAVA_PACKAGE git; \
    mkdir -p /opt/app; \
    wget $SPIGOT_BUILD_TOOLS_URL -P /opt/app

WORKDIR /opt/app
RUN java -jar BuildTools.jar --rev $MINECRAFT_VERSION

CMD [ "java", "-Xms${MINECRAFT_RAM_INI}", "-Xmx${MINECRAFT_RAM_MAX}", "-jar spigot-${MINECRAFT_VERSION}.jar"]