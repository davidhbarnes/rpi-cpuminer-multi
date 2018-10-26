#
# Dockerfile for rpi-cpuminer-multi
# usage: docker run davidhbarnes/rpi-cpuminer-multi -o stratum+tcp:// -u xxxx -pass x
#

FROM		resin/rpi-raspbian:latest
MAINTAINER	David H. Barnes <david@davidbarnes.net>

RUN		apt-get update -qq

RUN		apt-get install -qqy automake
RUN   apt-get install -qqy build-essential
RUN   apt-get install -qqy libcurl4-gnutls-dev
RUN		apt-get install -qqy libcurl4-openssl-dev
RUN		apt-get install -qqy git
RUN		apt-get install -qqy make

RUN		git clone https://github.com/davidhbarnes/rpi-cpuminer

RUN		cd cpuminer && ./autogen.sh
RUN		cd cpuminer && ./configure CFLAGS="-O3 -mfpu=neon"
RUN		cd cpuminer && make

WORKDIR		/cpuminer
ENTRYPOINT	["./minerd"]
