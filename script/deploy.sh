#!/bin/bash

# exit on any error
echo "deploying $TEBUKURO_IMAGE"
# cleanup any stale deploy-tasks jobs
kubectl delete job deploy-tasks 2&> /dev/null || true
# create the deploy-tasks job by creating a pod, running the migrate script
cat kubernetes/deploy-tasks-job.yml | envsubst | kubectl create -f -
while [ true ]; do
  phase=`kubectl get pods -a --selector="name=deploy-tasks" -o 'jsonpath={.items[0].status.phase}' || 'false'`
  if [[ "$phase" != 'Pending' ]]; then
    break
  fi
done

while [ true ]; do
  succeeded=`kubectl get jobs deploy-tasks -o 'jsonpath={.status.succeeded}'`
  failed=`kubectl get jobs deploy-tasks -o 'jsonpath={.status.failed}'`
  if [[ "$succeeded" == "1" ]]; then
    break
  elif [[ "$failed" -gt "0" ]]; then
    kubectl describe job deploy-tasks
    kubectl delete job deploy-tasks
    echo '!!! Deploy canceled. deploy-tasks failed.'
    exit 1
  fi
done
kubectl delete job deploy-tasks || true
