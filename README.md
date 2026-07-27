# Docker Kafka Kraft

> [!IMPORTANT]
> Forked version to add ARM support and updates to Kafka.
> Original repository: https://github.com/moeenz/docker-kafka-kraft

## Environment variables

| Variable                    | Description                                                                 |
| --------------------------- | --------------------------------------------------------------------------- |
| `KRAFT_CONTAINER_HOST_NAME` | Host name advertised on the internal listener. Unset exposes only `EXTERNAL`. |
| `KRAFT_EXTERNAL_HOST`       | Host advertised on the external listener (default `localhost`).               |
| `KRAFT_CREATE_TOPICS`       | Comma separated topics to create on startup.                                  |
| `KRAFT_PARTITIONS_PER_TOPIC`| Partitions used for the created topics (default `1`).                         |
| `KRAFT_AUTO_CREATE_TOPICS`  | Sets `auto.create.topics.enable`.                                             |
| `KRAFT_EXTRA_CONFIG`        | Arbitrary broker properties, see below.                                       |

### `KRAFT_EXTRA_CONFIG`

Any broker property that has no dedicated variable can be passed as `key=value`
pairs, separated by newlines and/or semicolons. They are appended to
`server.properties` last, so they override values set by the other variables.

```yaml
services:
  kafka:
    image: ghcr.io/baffinbay/docker-kafka-kraft:main-28
    environment:
      - KRAFT_EXTRA_CONFIG=group.initial.rebalance.delay.ms=0
```

Several properties at once:

```yaml
      - KRAFT_EXTRA_CONFIG=group.initial.rebalance.delay.ms=0;log.retention.hours=1
```

## Differences from the Kafka defaults

### `group.initial.rebalance.delay.ms=100` (Kafka default: `3000`)
