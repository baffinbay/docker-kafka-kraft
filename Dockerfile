FROM eclipse-temurin:24-alpine

WORKDIR /opt

ARG kafkaversion=4.3.1
ARG scalaversion=2.13

ENV KRAFT_CONTAINER_HOST_NAME=
ENV KRAFT_CREATE_TOPICS=
ENV KRAFT_PARTITIONS_PER_TOPIC=
ENV KRAFT_AUTO_CREATE_TOPICS=
ENV KRAFT_EXTERNAL_HOST=
ENV KRAFT_EXTRA_CONFIG=

RUN apk --no-cache add curl bash kcat

# The mirrors only carry current releases, so fall back to the archive once a
# version rotates out. -f is required or a 404 page gets written to kafka.tgz.
RUN (curl -fsSL -o kafka.tgz https://mirrors.ocf.berkeley.edu/apache/kafka/${kafkaversion}/kafka_${scalaversion}-${kafkaversion}.tgz \
        || curl -fsSL -o kafka.tgz https://archive.apache.org/dist/kafka/${kafkaversion}/kafka_${scalaversion}-${kafkaversion}.tgz) \
    && tar xzf kafka.tgz \
    && mv kafka_${scalaversion}-${kafkaversion} kafka \
    && rm kafka.tgz

WORKDIR /opt/kafka

RUN mkdir -p ./config/kraft
COPY ./configs/server.properties ./config/kraft

COPY ./*.sh .

EXPOSE 9092 9093

ENTRYPOINT [ "./docker-entrypoint.sh" ]
