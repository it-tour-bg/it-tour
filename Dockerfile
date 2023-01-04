FROM ruby:2.1.10

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends \
        postgresql-client \
        build-essential \
        libpq-dev \
        nodejs \
        libxml2-dev \
        libxslt-dev \
        npm \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install