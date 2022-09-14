# Kafka

Table of contents

* [Example of java.config for kafka interaction](#example-of-javaconfig-for-kafka-interaction)
* [List consumers in a consumer group](#list-consumers-in-a-consumer-group)

## Example of java.config for kafka interaction

```config
# Required connection configs for Kafka producer, consumer, and admin
bootstrap.servers=domain:9092
security.protocol=SASL_SSL
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule   required username='XXX'   password='T0K3Nn';
sasl.mechanism=PLAIN

```

## List consumers in a consumer group

```shell
kafka-consumer-groups \     
    --bootstrap-server domain:9092 \
    --command-config java.config \
    --group test-group \
    --describe \
    --members \
    --verbose

```