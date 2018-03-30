FROM node:9.10-alpine

RUN apk update && apk upgrade && apk add --update --no-cache python alpine-sdk

RUN mkdir /app
WORKDIR /app

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json

RUN npm install

ADD . /app
