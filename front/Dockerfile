FROM node:7.2.1

RUN apt-get update -qq
RUN npm install -g yarn
RUN mkdir /front_app
WORKDIR /front_app
ADD package.json /front_app/package.json
ADD yarn.lock /front_app/yarn.lock
RUN yarn install
ADD . /front_app
