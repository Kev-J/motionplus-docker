FROM debian:bookworm-slim

ARG TARGETPLATFORM
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        ca-certificates \
        libasound2 \
        libavcodec59 \
        libavdevice59 \
        libavformat59 \
        libavutil57 \
        libcamera0.0.3 \
        libfftw3-double3 \
        libjpeg62-turbo \
        libmariadb3 \
        libmicrohttpd12 \
        libopencv-core406 \
        libopencv-dnn406 \
        libopencv-imgcodecs406 \
        libopencv-imgproc406 \
        libopencv-objdetect406 \
        libpq5 \
        libpulse0 \
        libsqlite3-0 \
        libswscale6 \
        libwebp7 \
        libwebpmux3 \
        wget
RUN  if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; \
       elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; \
       elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; \
       else ARCHITECTURE=amd64; fi \
    && echo $ARCHITECTURE \
    && wget https://github.com/Motion-Project/motionplus/releases/download/release-0.2.1/bookworm_motionplus_0.2.1-1_$ARCHITECTURE.deb -O motionplus.deb \
    && dpkg -i motionplus.deb \
    && rm motionplus.deb \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /var/cache/apt

#start
#CMD ["/tmp/moti_start.sh"]
