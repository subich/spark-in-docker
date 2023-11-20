# Stage 1
FROM alpine:latest as spark-base

RUN apk add --no-cache \
    curl \
    bash \
    openjdk17-jre \
    python3 \
    py-pip \
    nss \
    libc6-compat \
    coreutils \
    procps \
    build-base \
    python3-dev \
    libffi-dev \
  && java --version \
  && python --version

ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"} \
    HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

RUN mkdir -p ${SPARK_HOME} && \
    mkdir -p ${HADOOP_HOME}

ENV SPARK_VERSION=3.4.0 \
    HADOOP_VERSION=3

RUN SPARK_BUNDLE_NAME="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    curl -O "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_BUNDLE_NAME}" && \
    tar xvzf $SPARK_BUNDLE_NAME --directory ${SPARK_HOME} --strip-components 1 && \
    rm -rf $SPARK_BUNDLE_NAME && \
    chmod u+x ${SPARK_HOME}/sbin/* && \
    chmod u+x ${SPARK_HOME}/bin/*

ENV PYTHONHASHSEED 1

# Stage 2
FROM spark-base AS pyspark

ENV SPARK_HOME=${SPARK_HOME:-"/opt/spark"} \
    HADOOP_HOME=${HADOOP_HOME:-"/opt/hadoop"}

# COPY --from=spark-base /usr/local /usr/local
COPY --from=spark-base ${SPARK_HOME} ${SPARK_HOME}
COPY --from=spark-base ${HADOOP_HOME} ${HADOOP_HOME}

WORKDIR ${SPARK_HOME}

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENV PATH="${SPARK_HOME}/sbin:${SPARK_HOME}/bin:${PATH}" \
    PYTHONPATH="${SPARK_HOME}/python:${PYTHONPATH}" \
    SPARK_MASTER_HOST=spark-master \
    SPARK_MASTER_PORT=7077

# ENV SPARK_MASTER="spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}"

COPY conf/spark-defaults.conf "${SPARK_HOME}/conf/"

# Copy appropriate entrypoint script
COPY --chmod=u+x entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
