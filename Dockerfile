FROM ruby:latest

## -----------------------------------------------------------------------------
## Installing dependencies
## -----------------------------------------------------------------------------
RUN set -xe \
  && apt-get update -qq \
  && apt-get -y install \
    build-essential \
    libpq-dev \
    nodejs \
    netcat \
    tmux

ENV app /finka
RUN mkdir $app
WORKDIR $app

ENV BUNDLE_PATH /box
ADD . $app

RUN mv $app/.tmux.conf /root/
