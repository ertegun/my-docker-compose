FROM ubuntu:18.04
LABEL maintainer="Your Name <your.email@domain.com>"
ENV DEBIAN_FRONTEND=noninteractive
COPY zcs-* /tmp/
RUN apt-get update && \
  apt-get install -y sudo libidn11 wget libgmp-dev libxml2-dev libstdc++6 libperl5.26 perl-modules curl netcat-openbsd tzdata && \
  cd /tmp && \
  ./install.sh -s < zcs-mailbox-default-configure-no-spam.sh && \
  rm -rf /tmp/*
VOLUME [ "/opt/zimbra" ]
EXPOSE 25 80 110 143 443 465 587 993 995 7071
ENTRYPOINT [ "/opt/zimbra/bin/zmcontrol", "start" ]
