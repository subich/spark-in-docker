FROM spark-base

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077

COPY submit.sh /

CMD ["/bin/bash", "/submit.sh"]
