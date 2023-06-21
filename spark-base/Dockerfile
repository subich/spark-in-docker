FROM alpine:latest

ARG SPARK_VERSION
ARG HADOOP_VERSION
ENV BASE_URL="https://archive.apache.org/dist/spark"

RUN apk add --no-cache curl openjdk17-jre python3 py-pip \
  && java --version \
  && python --version \
  && SPARK_BUNDLE_NAME="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" \
  && SPARK_URL="${BASE_URL}/spark-${SPARK_VERSION}/${SPARK_BUNDLE_NAME}.tgz" \
  && curl $SPARK_URL | tar -xvzf - \
  && mv $SPARK_BUNDLE_NAME /spark \
  && cd /

ENTRYPOINT []
