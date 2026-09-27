# Build LanguageTool from source
FROM docker.io/library/maven:3.9-eclipse-temurin-21 AS builder

ARG LT_REF=master

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN git clone --depth 1 --branch "${LT_REF}" \
    https://github.com/languagetool-org/languagetool.git .

RUN mvn -pl languagetool-server -am \
    -Pfat-jar package -DskipTests


# Runtime image
FROM docker.io/library/eclipse-temurin:21-jre

LABEL org.opencontainers.image.source="https://github.com/Mr-Dazmo/languagetool-selfhosted"

WORKDIR /opt/languagetool

COPY --from=builder \
    /build/languagetool-server/target/languagetool-server-*.jar \
    /opt/languagetool/languagetool-server.jar

COPY --from=builder \
    /build/COPYING.txt \
    /opt/languagetool/COPYING.txt

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "/opt/languagetool/languagetool-server.jar"]
CMD ["--port", "8081", "--public"]
