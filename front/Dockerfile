FROM node:7.3.0-alpine

RUN apk update && apk upgrade && apk add --update --no-cache python gcc g++ make
RUN npm install -g yarn
RUN mkdir /front_app
WORKDIR /front_app
ADD package.json /front_app/package.json
ADD yarn.lock /front_app/yarn.lock
RUN yarn install
ADD . /front_app
