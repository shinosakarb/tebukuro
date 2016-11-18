FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4
ADD . /app

ENV DATABASE_HOST db
ENV DATABASE_USERNAME postgres
ENV DATABASE_PASSWORD ""
ENV SLACK_URL https://hooks.slack.com/services/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