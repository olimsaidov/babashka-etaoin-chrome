FROM babashka/babashka:1.3.190-alpine as deps

RUN apk add --no-cache openjdk21-jdk

RUN echo "{:deps {etaoin/etaoin {:mvn/version \"1.0.40\"}}}" > bb.edn && \
    bb uberjar deps.jar


FROM babashka/babashka:1.3.190-alpine

RUN apk add --no-cache chromium-chromedriver
COPY --from=deps deps.jar /deps.jar

ENTRYPOINT ["bb", "-cp", "/deps.jar"]
