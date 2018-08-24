FROM ruby:latest
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /maxemail_gem
WORKDIR /maxemail_gem
COPY maxemail_api.gemspec /maxemail_gem/maxemail_api.gemspec
COPY Gemfile /maxemail_gem/Gemfile
COPY Gemfile.lock /maxemail_gem/Gemfile.lock
RUN bundle install
COPY . /maxemail_gem
