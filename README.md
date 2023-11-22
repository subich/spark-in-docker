# Docker Image for Apache Spark

This repo a Dockerfile, Spark supporting files, and a compose file for running a complete Spark cluster in Docker.

It is based on alpine linux and installs everything required to run Python 3 applications in Spark.

The docker-compose file will start a master node, a worker node, and the Spark history server.

It can be scaled by passing `--scale worker=n` to the `docker compose up` command, where `n` is the number of desired worker nodes.
