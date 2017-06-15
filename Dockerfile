#
# Middleman static website baseimage docker image
# Based on:
# http://github.com/tenstartups/middleman-docker
#

FROM ruby:2.2-onbuild

# Define working directory.
WORKDIR /usr/src/app

# Install ruby gems.
RUN \
  echo "gem: --no-document" > ${HOME}/.gemrc && \
   gem install bundler --no-document && \
   gem install rb-inotify

# Define the entrypoint
ENTRYPOINT ["./docker-entrypoint.sh"]

# Expose ports.
EXPOSE 4567
