FROM redis:2.8.19
MAINTAINER Dave Yarwood <dave@adzerk.com>

ENV DEBIAN_FRONTEND noninteractive

# Oracle Java 8

RUN apt-get update \
    && apt-get install -y curl wget openssl ca-certificates \
    && cd /tmp \
    && wget -qO jdk8.tar.gz \
       --header "Cookie: oraclelicense=accept-securebackup-cookie" \
       http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz \
    && tar xzf jdk8.tar.gz -C /opt \
    && mv /opt/jdk* /opt/java \
    && rm /tmp/jdk8.tar.gz \
    && update-alternatives --install /usr/bin/java java /opt/java/bin/java 100 \
    && update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 100 \
    && wget -O /usr/bin/boot https://github.com/boot-clj/boot-bin/releases/download/2.4.2/boot.sh \
    && chmod +x /usr/bin/boot

ENV JAVA_HOME /opt/java

# Boot

ENV BOOT_HOME /.boot
ENV BOOT_AS_ROOT yes
ENV BOOT_LOCAL_REPO /m2
ENV BOOT_JVM_OPTIONS=-Xmx2g
ENV BOOT_VERSION 2.4.2
ENV BOOT_CLOJURE_VERSION 1.7.0

# download & install deps, cache REPL and web deps
RUN /usr/bin/boot web -s doesnt/exist repl -e '(System/exit 0)' && rm -rf target

ENTRYPOINT ["/usr/bin/boot"]

