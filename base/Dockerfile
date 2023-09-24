FROM alpine:latest

ENV ENABLE_INIT_DAEMON false
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV BASE_URL="https://archive.apache.org/dist/spark"
ENV SPARK_VERSION=3.4.0
ENV HADOOP_VERSION=3

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

RUN apk add --no-cache curl bash openjdk17-jre python3 py-pip nss libc6-compat coreutils procps build-base python3-dev libffi-dev \
  && java --version \
  && python --version \
  && SPARK_BUNDLE_NAME="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" \
  && SPARK_URL="${BASE_URL}/spark-${SPARK_VERSION}/${SPARK_BUNDLE_NAME}.tgz" \
  && curl $SPARK_URL | tar -xvzf - \
  && mv $SPARK_BUNDLE_NAME /spark \
  && cd /

RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

ENV PYTHONHASHSEED 1
