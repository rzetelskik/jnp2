FROM ruby:2.7.1-alpine3.11 AS prebuild
ENV BUNDLER_VERSION=2.1.4
RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
    build-base \
    tzdata \
    mariadb-dev

ARG GEM_HOME=/usr/local/bundle
ARG APP_OPT=/opt/app/
RUN gem install bundler -v $BUNDLER_VERSION
ADD Gemfile Gemfile.lock $APP_OPT
WORKDIR $APP_OPT

RUN bundle install \
    && rm -rf $GEM_HOME/cache \
    && find $GEM_HOME/gems/ -name "*.c" -delete \
    && find $GEM_HOME/gems/ -name "*.o" -delete \
    && rm -rf $GEM_HOME/bundler/gems/*/.git

FROM ruby:2.7.1-alpine3.11

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
    build-base \
    mariadb-dev \
    openssh \
    bash

ARG APP_OPT=/opt/app/
WORKDIR $APP_OPT
COPY --from=prebuild /usr/local/bundle /usr/local/bundle
ADD . $APP_OPT

VOLUME ["$APP_OPT/public"]
EXPOSE 80
CMD PORT=80 RAILS_ENV=development bundle exec puma -C config/puma.rb





