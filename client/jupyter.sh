#!/usr/bin/env bash

HOSTNAME=$1

echo "Starting jupyter on ${HOSTNAME}..."
PORT=`ssh ${HOSTNAME} sh j_run.sh | tail -n 1`
echo "Started jupyter notebook on ${HOSTNAME} port ${PORT}"
ssh -N -L ${PORT}:localhost:${PORT} ${HOSTNAME} &
TUNNEL=$!
sleep 3
echo "URL: http://localhost:${PORT}"
xdg-open http://localhost:${PORT}

wait $TUNNEL
