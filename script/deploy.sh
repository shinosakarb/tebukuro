#!/bin/bash

$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/migrate-job.sh
cat kubernetes/tebukuro.yml | envsubst | kubectl apply -f -
kubectl describe deployment tebukuro
kubectl rollout status deployment/tebukuro
