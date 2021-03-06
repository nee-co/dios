FROM ruby:2.3.1-alpine
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
RUN apk add --no-cache --update mariadb-dev tzdata nodejs && \
    apk add --no-cache --virtual build-dependencies \
    git \
    build-base \
    libxml2-dev \
    libxslt-dev
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install --without test development && apk del build-dependencies
COPY . /app
RUN DIOS_SECRET_KEY_BASE=x bundle exec rake assets:precompile
CMD ["bundle", "exec", "rails", "server"]
ARG REVISION
LABEL revision=$REVISION maintainer="Nee-co"
