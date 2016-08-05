FROM ruby:2.3.1-alpine
MAINTAINER Nee-co
RUN apk --no-cache --update add mariadb-dev tzdata nodejs && \
    apk add --no-cache --virtual build-dependencies \
    build-base \
    libxml2-dev \
    libxslt-dev && \
    bundle config build.nokogiri --use-system-libraries && \
    gem install -N bundler nokogiri
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install && apk del build-dependencies
COPY . /app
CMD ["bundle", "exec", "rails", "server"]
