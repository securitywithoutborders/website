#
# Middleman static website baseimage docker image
# Based on:
# http://github.com/tenstartups/middleman-docker
#

FROM ruby:2.2-onbuild

# Install base packages.
# RUN \
#   apt-get install build-base git graphviz libffi-dev libxml2-dev libxslt-dev \
#                nodejs openssl-dev rsync ruby ruby-bigdecimal ruby-bundler \
#                ruby-dev ruby-io-console ruby-irb ruby-json zlib-dev 

# Define working directory.
WORKDIR /usr/src/app

# Install ruby gems.
RUN \
  echo "gem: --no-document" > ${HOME}/.gemrc && \
   gem install bundler --no-document && \
   gem install rb-inotify

# Copy the rest of the application into place.
# COPY . /usr/src/web

# Define the entrypoint
ENTRYPOINT ["./docker-entrypoint.sh"]

# Expose ports.
EXPOSE 4567
