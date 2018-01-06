# Deployment method

## Nginx container build and push
```bash
# docker build
$ docker build -t us.gcr.io/tebukuro-182304/nginx:0.0.1 kubernetes/nginx/.
# docker push
$ gcloud docker -- push us.gcr.io/tebukuro-182304/nginx:0.0.1
```

## Rails container build and push
```bash
# docker build
$ docker-compose build --build-arg BUNDLE_OPTIONS='--without development test' backend
# create docker tag
$ docker tag tebukuro_backend us.gcr.io/tebukuro-182304/tebukuro_backend:latest
# docker push
$ gcloud docker -- push us.gcr.io/tebukuro-182304/tebukuro_backend:latest
```

## Container setting
```bash
# get credentials
$ gcloud container clusters get-credentials tebukuro-cluster
# create database stroge
$ gcloud compute disks create --size 5GB postgresql-disk
# create secret
$ kubectl create -f ~/.kube/tebukuro-secret.yml
```

## Create database container
```bash
# create postgreSQL deployment
$ kubectl create -f kubernetes/postgresql.yml
# create postgreSQL service
$ kubectl create -f kubernetes/postgresql-service.yml
```

## Create application container
```bash
# create tebukuro deployment
$ export TEBUKURO_IMAGE=us.gcr.io/tebukuro-182304/tebukuro_backend:latest
$ cat kubernetes/tebukuro.yml | envsubst | kubectl create -f -
# create tebukuro service
$ kubectl create -f kubernetes/nginx-service.yml
```

## Deploy(migrate) task
```bash
$ export TEBUKURO_IMAGE=us.gcr.io/tebukuro-182304/tebukuro_backend:latest
$ ./script/deploy.sh
```

## deploy web containers
```bash
#kubectl set image deployments/tebukuro "web=$TEBUKURO_IMAGE"
$ cat kubernetes/tebukuro.yml | envsubst | kubectl apply -f -
$ kubectl describe deployment tebukuro
$ kubectl rollout status deployment/tebukuro
```
