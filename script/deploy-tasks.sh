#!/bin/sh

set -e

bundle exec rails db:create
bundle exec rails db:migrate
