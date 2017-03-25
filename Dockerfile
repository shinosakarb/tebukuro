FROM ruby:2.4.1-alpine

RUN apk update && apk upgrade && apk add --update --no-cache alpine-sdk tzdata postgresql-dev nodejs postgresql-client
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --path vendor/bundle -j4
ADD . /app
