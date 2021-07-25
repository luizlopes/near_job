FROM ruby:2.6.8-alpine

RUN apk update \
      && apk upgrade \
      && apk add --update \
      tzdata \
      sqlite-dev \
      git \
      linux-headers \
      build-base \
      && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/near_job

EXPOSE 9000

WORKDIR /var/www/near_job
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN gem install bundler-audit

ADD . /var/www/near_job
RUN bin/setup
CMD ["rails","server","-b","0.0.0.0","-p","9000"]
