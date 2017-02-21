#!/bin/bash
sed -i -e "s/PH_BROKER_ID/$BROKER_ID/g" $KAFKA_HOME/config/server.properties
sed -i -e "s/PH_BROKER_IP/$BROKER_IP/g" $KAFKA_HOME/config/server.properties
sed -i -e "s/PH_BROKER_PORT/$BROKER_PORT/g" $KAFKA_HOME/config/server.properties
sed -i -e "s/PH_ZK_PORT/$ZK_PORT/g" $KAFKA_HOME/config/server.properties
exec $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties