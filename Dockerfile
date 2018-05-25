FROM ubuntu:16.04
RUN apt-get update && apt-get install -y -q  sudo curl build-essential python3-dev python3-venv openssh-server

RUN apt-get install -y -q tig
RUN useradd -d /home/sh1 -ns /bin/bash -g root -G sudo -p sh1 sh1

RUN apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev git libgstreamer0.10-dev libv4l-dev

RUN apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

USER sh1
RUN mkdir /home/sh1/jupyter_server
WORKDIR /home/sh1/jupyter_server
RUN python3 -m venv venv

