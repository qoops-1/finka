FROM ruby:latest

## -----------------------------------------------------------------------------
## Installing dependencies
## -----------------------------------------------------------------------------
RUN set -xe \
  && apt-get update -qq \
  && apt-get -y --no-install-recommends install \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    htop \
    less \
    libcurl4-openssl-dev \
    libmysqlclient-dev \
    libpq-dev \
    lsb-release \
    nodejs \
    make \
    rsyslog \
    software-properties-common \
    ssh \
    sudo \
    tmux \
    vim-nox \
    wget

ENV app /finka
RUN mkdir $app
WORKDIR $app

ENV BUNDLE_PATH /box
ADD . $app

RUN mv $app/.tmux.conf /root/
ENTRYPOINT ["/bin/bash"]