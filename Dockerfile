FROM ubuntu:14.04

RUN apt-get update && apt-get -y install \
  libjpeg-dev \
  libcairo-dev \
  libossp-uuid-dev \
  libssl-dev \
  libvorbis-dev \
  libpulse-dev \
  libfreerdp-dev \
  libwebp-dev \
  libpango1.0-dev \
  libssh-dev \
  libssh2-1-dev \
  libtelnet-dev \
  libvncserver-dev \
  build-essential \
  dh-autoreconf \
  autotools-dev \
  libcunit1-dev

ENV guacamole_version 0.9.9
ENV cachedir /var/cache/build

RUN mkdir ${cachedir}
COPY debian ${cachedir}/debian
ADD http://netcologne.dl.sourceforge.net/project/guacamole/current/source/guacamole-server-${guacamole_version}.tar.gz ${cachedir}
# ADD http://netcologne.dl.sourceforge.net/project/guacamole/current/source/guacamole-client-${guacamole_version}.tar.gz ${cachedir}
# ADD http://netcologne.dl.sourceforge.net/project/guacamole/current/binary/guacamole-${guacamole_version}.war ${cachedir}
RUN chmod 644 /var/cache/build/*.tar.gz

RUN adduser --disabled-password --uid 1000 --gecos "build user" build
USER build
ENV builddir /home/build
WORKDIR ${builddir}
RUN tar -xzf ${cachedir}/guacamole-server-${guacamole_version}.tar.gz
RUN cp -a ${cachedir}/debian guacamole-server-${guacamole_version}/

CMD /bin/bash

