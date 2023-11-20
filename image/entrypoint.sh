#!/bin/bash

SPARK_MASTER_HOST=${SPARK_MASTER_HOST:-"spark-master"}
SPARK_MASTER_PORT=${SPARK_MASTER_PORT:-"7077"}

SPARK_WORKLOAD=$1

case $SPARK_WORKLOAD in
master)
	echo "Starting Spark master node"
	start-master.sh -p "$SPARK_MASTER_PORT"
	;;
worker)
	WORKER_PORT=${2:-8081}
	echo "Starting Spark worker node with web UI on port $WORKER_PORT"
	start-worker.sh "spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}" \
		--webui-port "$WORKER_PORT"
	;;
history)
	echo "Starting Spark History Server"
	start-history-server.sh
	;;
spark-submit)
	echo "Submitting work to master:" "${@:2}"
	spark-submit --master "spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT}" "${@:2}"
	;;
*)
	echo "Unrecognized workload."
	echo "Executing command:" "$@"
	exec "$@"
	;;
esac
