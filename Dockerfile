FROM ubuntu
COPY ./motionplus/ /tmp/motionplus/
WORKDIR /tmp/motionplus


RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
autoconf automake autopoint build-essential pkgconf libtool libzip-dev libjpeg-dev git libavformat-dev libavcodec-dev libavutil-dev libswscale-dev libavdevice-dev libopencv-dev libwebp-dev gettext libmicrohttpd-dev libmariadb-dev libasound2-dev libpulse-dev libfftw3-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists && \
  autoreconf -fiv && \
  ./configure && \
  make && \
  make install && \
  rm -rf /tmp/motionplus

WORKDIR /usr/local/bin/

#SCRIPT
COPY ./files/moti_start.sh /tmp/moti_start.sh
RUN ["chmod", "+x", "/tmp/moti_start.sh"]

#Старт
CMD ["/tmp/moti_start.sh"]
