FROM saorikido/docker-alpine_3.11.3-glibc:latest

ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# Copy JDK file
COPY jre-8u241-linux-x64.tar.gz /opt/jre-8u241-linux-x64.tar.gz

RUN mkdir -p /usr/lib/jvm && \
    tar -xvzf /opt/jre-8u241-linux-x64.tar.gz -C /usr/lib/jvm/ && \
    ln -s "/usr/lib/jvm/jre1.8.0_241" "${JAVA_HOME}" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip &&\
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" && \
    unzip -jo -d "${JAVA_HOME}/lib/security" "jce_policy-8.zip" && \
    \
    apk del wget && \
    apk del unzip && \
    apk del ca-certificates && \
    apk del build-dependencies

CMD ["sh", "-c", "java -version" ]
