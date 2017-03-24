# Users can build and initialize the container like this:
# docker build --build-arg UID=`id -u` --build-arg GID=`id -g` -t adgaudio/wine -f wine.Dockerfile .
# docker run --name wine -e DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix adgaudio/wine
FROM debian:latest

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y --no-install-recommends wine wget \
  && wget http://www.kegel.com/wine/winetricks
ENV DISPLAY :0

ARG UID=1000
ARG GID=1000

RUN addgroup --gid=${GID} wineuser \
  && useradd -ms /bin/bash --uid ${UID} --gid=${GID} wineuser
USER wineuser
