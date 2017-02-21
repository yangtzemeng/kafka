FROM java:openjdk-8-jre

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.1.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

ENV BROKER_ID 0
ENV BROKER_IP 127.0.0.1
ENV BROKER_PORT 9092
# ENV ZK_IP linked
ENV ZK_PORT 2181

# Install Kafka and other needed things
# http://mirror.netinch.com/pub/apache/kafka/0.10.1.1/kafka_2.10-0.10.1.1.tgz
RUN apt-get update && \
    apt-get install -y wget supervisor dnsutils && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    wget -q http://mirror.netinch.com/pub/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    rm $KAFKA_HOME/config/server.properties

VOLUME /tmp/kafka-logs

COPY conf/server-example.properties $KAFKA_HOME/config/server.properties

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE $BROKER_PORT

# CMD ["/bin/sh"]
# CMD ["sh", "-c", "$KAFKA_HOME/bin/kafka-server-start.sh", "$KAFKA_HOME/config/server.properties"]
