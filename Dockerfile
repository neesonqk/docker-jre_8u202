FROM saorikido/docker-alpine_3.11.3-glibc:latest

ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# Copy JRE file
COPY jre-8u202-linux-x64.tar.gz /opt/jre-8u202-linux-x64.tar.gz

RUN mkdir -p /usr/lib/jvm && \
    tar -xvzf /opt/jre-8u202-linux-x64.tar.gz -C /usr/lib/jvm/ && \
    ln -s "/usr/lib/jvm/jre1.8.0_202" "${JAVA_HOME}" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm /opt/jre-8u202-linux-x64.tar.gz && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" \
           "$JAVA_HOME/lib/visualvm" \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/lib/plugin.jar" \
           "$JAVA_HOME/lib/ext/jfxrt.jar" \
           "$JAVA_HOME/bin/javaws" \
           "$JAVA_HOME/lib/javaws.jar" \
           "$JAVA_HOME/lib/desktop" \
           "$JAVA_HOME/plugin" \
           "$JAVA_HOME/lib/"deploy* \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/lib/"*jfx* \
           "$JAVA_HOME/lib/amd64/libdecora_sse.so" \
           "$JAVA_HOME/lib/amd64/"libprism_*.so \
           "$JAVA_HOME/lib/amd64/libfxplugins.so" \
           "$JAVA_HOME/lib/amd64/libglass.so" \
           "$JAVA_HOME/lib/amd64/libgstreamer-lite.so" \
           "$JAVA_HOME/lib/amd64/"libjavafx*.so \
           "$JAVA_HOME/lib/amd64/"libjfx*.so && \
    rm -rf "$JAVA_HOME/bin/jjs" \
           "$JAVA_HOME/bin/keytool" \
           "$JAVA_HOME/bin/orbd" \
           "$JAVA_HOME/bin/pack200" \
           "$JAVA_HOME/bin/policytool" \
           "$JAVA_HOME/bin/rmid" \
           "$JAVA_HOME/bin/rmiregistry" \
           "$JAVA_HOME/bin/servertool" \
           "$JAVA_HOME/bin/tnameserv" \
           "$JAVA_HOME/bin/unpack200" \
           "$JAVA_HOME/lib/ext/nashorn.jar" \
           "$JAVA_HOME/lib/jfr.jar" \
           "$JAVA_HOME/lib/jfr" \
           "$JAVA_HOME/lib/oblique-fonts" && \
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
