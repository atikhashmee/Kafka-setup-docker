FROM ubuntu:20.04

# Environment variables
ENV KAFKA_VERSION=3.9.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka

# Set up Kafka directories
WORKDIR /tmp

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl wget vim openjdk-21-jdk \
    && apt-get clean

# Download and extract Kafka
RUN wget https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} \
    && rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Set working directory
WORKDIR ${KAFKA_HOME}

# Copy custom scripts and configurations
COPY server-start.sh /usr/local/bin/server-start
RUN chmod +x /usr/local/bin/server-start
COPY server.properties ${KAFKA_HOME}/config/server.properties
COPY zookeeper.properties ${KAFKA_HOME}/config/zookeeper.properties

# Expose ports for Kafka and Zookeeper
EXPOSE 9092 2181

# Define entry point
ENTRYPOINT ["server-start"]
