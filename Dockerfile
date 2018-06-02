FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update && apt-get -y install \
    perl \
    libnet-server-perl \
    libusb-1.0-0-dev \
    bluetooth \
    bluez \
    blueman \
    tzdata \
    bluez-hcidump \
    wget && \
    apt-get clean && cd / && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
WORKDIR "/opt"

RUN wget https://github.com/mhop/fhem-mirror/raw/master/fhem/contrib/PRESENCE/lepresenced && \
    chmod +x lepresenced && \
    chgrp -cR dialout lepresenced

CMD /usr/bin/perl /opt/lepresenced --device "hci0" --listenaddress "0.0.0.0" --listenport 5333 --loglevel "LOG_WARNING" --logtarget stdout
