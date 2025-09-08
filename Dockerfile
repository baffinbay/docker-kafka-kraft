FROM eclipse-temurin:24-alpine

WORKDIR /opt

ARG kafkaversion=4.0.0
ARG scalaversion=2.13

ENV KRAFT_CONTAINER_HOST_NAME=
ENV KRAFT_CREATE_TOPICS=
ENV KRAFT_PARTITIONS_PER_TOPIC=
ENV KRAFT_AUTO_CREATE_TOPICS=
ENV KRAFT_EXTERNAL_HOST=

RUN apk --no-cache add curl bash kcat

RUN curl -o kafka.tgz https://mirrors.ocf.berkeley.edu/apache/kafka/${kafkaversion}/kafka_${scalaversion}-${kafkaversion}.tgz \
    && tar xvzf kafka.tgz \
    && mv kafka_${scalaversion}-${kafkaversion} kafka

WORKDIR /opt/kafka

RUN mkdir -p ./config/kraft
COPY ./configs/server.properties ./config/kraft

COPY ./*.sh .

EXPOSE 9092 9093

ENTRYPOINT [ "./docker-entrypoint.sh" ]
