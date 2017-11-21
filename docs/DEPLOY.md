```bash
# docker build
$ docker-compose build --build-arg BUNDLE_OPTIONS='--without development test' backend
# create docker tag
$ docker tag tebukuro_backend us.gcr.io/tebukuro-182304/tebukuro_backend:latest
# docker push
$ gcloud docker -- push us.gcr.io/tebukuro-182304/tebukuro_backend:latest

# create database stroge
$ gcloud compute disks create --size 5GB postgresql-disk

# get credentials
$ gcloud container clusters get-credentials tebukuro-cluster-free

# create secret
$ kubectl create -f ~/.kube/tebukuro-secret.yml

# create postgreSQL deployment
$ kubectl create -f kubernetes/postgresql.yml
# create postgreSQL service
$ kubectl create -f kubernetes/postgresql-service.yml 

# create tebukuro deployment
$ export TEBUKURO_IMAGE=us.gcr.io/tebukuro-182304/tebukuro_backend:latest
$ cat kubernetes/tebukuro.yml | envsubst | kubectl create -f -
# update tebukuro deployment 
# $ cat kubernetes/tebukuro.yml | envsubst | kubectl apply -f -

# create tebukuro service
$ kubectl create -f kubernetes/tebukuro-service.yml
```
