FROM ruby:2.4.4

RUN apt-get update -qq  && apt-get install -y build-essential postgresql-client && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ru_RU.UTF-8

ENV LANG ru_RU.UTF-8

RUN mkdir /app
WORKDIR /app
ENV RAILS_ENV production
ENV BUNDLE_PATH /bundle

COPY . .
RUN gem install bundler
RUN bundle install --without development test

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD puma -C config/puma.rb
