```bash
# docker build
$ docker-compose build --build-arg BUNDLE_OPTIONS='--without development test' backend
# create docker tag
$ docker tag tebukuro_backend us.gcr.io/tebukuro-182304/tebukuro_backend:latest
# docker push
$ gcloud docker -- push us.gcr.io/tebukuro-182304/tebukuro_backend:latest
# kubectl auth
$ kubectl create secret generic cloudsql-oauth-credentials --from-file=credentials.json=<json_key>
```
