FROM ruby:2.3.1-alpine
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
RUN apk --no-cache --update add mariadb-dev tzdata nodejs && \
    apk add --no-cache --virtual build-dependencies \
    git \
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
RUN DIOS_SECRET_KEY_BASE=x bundle exec rake assets:precompile
CMD ["bundle", "exec", "rails", "server"]
ARG REVISION
LABEL revision=$REVISION maintainer="Nee-co"
