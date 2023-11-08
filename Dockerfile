
FROM ubuntu

COPY ./motionplus/ /tmp/motionplus/
WORKDIR /tmp/motionplus


RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  autoconf automake autopoint build-essential pkgconf libtool libzip-dev libjpeg-dev git \
  libavformat-dev libavcodec-dev libavutil-dev libswscale-dev libavdevice-dev libopencv-dev \
  libwebp-dev gettext libmicrohttpd-dev libmariadb-dev libasound2-dev libpulse-dev libfftw3-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists && \
  autoreconf -fiv && \
  ./configure && \
  make && \
  make install && \
  rm -rf /tmp/motionplus


RUN apt-get autoremove -y

#clean
RUN DEBIAN_FRONTEND=noninteractive apt-get clean
RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove
RUN DEBIAN_FRONTEND=noninteractive rm -rf /var/cache/apt

#copy_conf
COPY ./files/motionplus-dist.conf /usr/local/etc/motionplus/

#copy
COPY ./files/moti_start.sh /tmp/moti_start.sh
RUN ["chmod", "+x", "/tmp/moti_start.sh"]

#start
CMD ["/tmp/moti_start.sh"]
