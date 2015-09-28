FROM python:3.5.0

MAINTAINER Leo Gallucci <elgalu3@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

#========================
# Miscellaneous packages
#========================
RUN apt-get update -qqy \
  && apt-get -qqy install \
    unzip \
  && rm -rf /var/lib/apt/lists/*

# https://github.com/elgalu/selenium-test/commits/master
ENV SEL_TEST_SHA="99c2b9f6e45c9293803c29e21a55d7554d7f7bc5"

# Check the README.md to see how to run this with docker-selenium
ENV SEL_HOST=localhost \
    SEL_PORT=24444

RUN mkdir -p /root/tmp && cd /root/tmp \
  && wget --no-verbose -O selenium-test.zip \
      "https://github.com/elgalu/selenium-test/archive/${SEL_TEST_SHA}.zip" \
  && unzip -x selenium-test.zip \
  && mv selenium-test-${SEL_TEST_SHA} /root/selenium-test

RUN cd /root/selenium-test \
  && pip install --upgrade -r requirements.txt

ADD hola /usr/bin/

CMD hola
