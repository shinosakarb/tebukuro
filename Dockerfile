FROM ruby:2.4.5-alpine3.7

ENV LANG C.UTF-8
ENV BUNDLE_FORCE_RUBY_PLATFORM 1

RUN apk update && apk upgrade && apk add --update --no-cache alpine-sdk tzdata postgresql-dev nodejs postgresql-client
RUN mkdir /app
WORKDIR /app

ARG BUNDLE_OPTIONS

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --path vendor/bundle -j4 ${BUNDLE_OPTIONS}
ADD . /app

EXPOSE  3000
