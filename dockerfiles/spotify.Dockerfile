# Spotify Client
#
# Users can build and initialize the container like this:
# docker build --build-arg UID=`id -u` --build-arg AUDIO_GID=`getent group audio | cut -d: -f3` -t adgaudio/spotify -f spotify.Dockerfile .
# docker run -d --name spotify --device /dev/snd -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -e DISPLAY adgaudio/spotify
#
# then, to use regularly, just do:  docker start spotify

FROM ubuntu:16.04

ARG UID=1000
ARG AUDIO_GID=92

# install spotify as described on website and user
# https://www.spotify.com/us/download/linux/
RUN useradd -ms /bin/bash --uid ${UID} spotifyu \
  && apt-key adv \ 
    --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 \
  && echo deb http://repository.spotify.com stable non-free \
    | tee /etc/apt/sources.list.d/spotify.list \
  && apt-get update && apt-get install -y spotify-client \
  && rm -rf /var/lib/apt/lists/*

# add user to audio group.  try to resolve situation if the GIDs mismatch
RUN group_name=audio \
  ; [ "`getent group audio | cut -d: -f3`" = "${AUDIO_GID}" ] \
    || group_name=audio2 \
  ; addgroup --gid ${AUDIO_GID} $group_name \
  && adduser spotifyu $group_name

USER spotifyu
CMD spotify
