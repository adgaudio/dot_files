FROM ubuntu:latest
# 3d printer setup... everything in one big fat container for now.

USER root

RUN apt-get update && apt-get install -y \
  openscad \
  arduino arduino-core \
  libcanberra-gtk-module \
  libcanberra-gtk3-module \
  freeglut3

# Printrun dependencies
RUN apt-get install -y \
  python-wxgtk3.0 \
  python-dbus \
  python-gobject \
  python-pyglet \
  python-libxml2 \
  python-numpy \
  python-psutil \
  python-serial \
  cython \
  git \
  subversion
RUN svn checkout svn://svn.code.sf.net/p/pyserial/code/trunk pyserial-code \
  && cd pyserial-code/pyserial/ \
  && python setup.py build && python setup.py install

# programmer stuff
RUN apt-get update && apt-get install -y \
  dfu-programmer libusb-1.0.0 avrdude avrdude-doc

RUN useradd dev && echo 'dev:dev' | chpasswd && adduser dev sudo \
  ; adduser dev dialout \
  ; mkdir /home/dev \
  ; mkdir -p /home/dev/bin /home/dev/lib /home/dev/include \
  ; chown -R dev: /home/dev
ENV PATH /home/dev/bin:$PATH
ENV PKG_CONFIG_PATH /home/dev/lib/pkgconfig
ENV LD_LIBRARY_PATH /home/dev/lib
ENV HOME /home/dev

WORKDIR /home/dev/s

USER dev

# Assume Github data mounted into a volume
RUN ln -s $HOME/s/printer/Slic3r_settings_config $HOME/.Slic3r
RUN echo 'export PATH="$HOME/s/printer/Slic3r/bin":"$HOME/s/printer/Printrun":"$HOME/s/printer/OpenSCAD-Tools":$PATH' >> ~/.bashrc