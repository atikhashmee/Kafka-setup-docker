#!/bin/bash

# Start Zookeeper in the background
${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &

# Wait for Zookeeper to start
sleep 5

# Start Kafka
exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties