# References used:
# https://github.com/phusion/baseimage-docker
# http://docs.casperjs.org/en/latest/installation.html
FROM quay.io/nakanaa/phantomjs:1.9.8
MAINTAINER nakanaa

# Set correct environment variables
ENV REFRESHED_AT 22.02.2015
ENV HOME /root
WORKDIR $HOME

RUN \
  apt-get -q -y update && DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
      # Install unzip
	  unzip && \
  # Clean up APT when done
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  # Link the default Ubuntu Python 3 installation to /usr/bin/python
  ln -s /usr/bin/python3 /usr/bin/python

ENV CASPERJS_VERSION 1.1-beta3

RUN \
  # Download CasperJS
  wget https://github.com/n1k0/casperjs/archive/${CASPERJS_VERSION}.zip && \
  # Extract
  unzip *.zip && \
  # Copy folder
  cp -r */ /usr/local/casperjs && \
  # Make symbolic links
  ln -s /usr/local/casperjs/bin/casperjs /usr/local/bin/casperjs && \
  ln -s /usr/local/bin/casperjs /usr/bin/casperjs && \
  # Remove downloaded files
  rm -rf *

# Use baseimage-docker's init system
ENTRYPOINT ["/sbin/my_init", "--"]

# Define default command
CMD ["/usr/bin/casperjs"]