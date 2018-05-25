FROM ubuntu:16.04
RUN apt-get update && apt-get install -y -q  sudo curl build-essential python3-dev python3-venv openssh-server

RUN apt-get install -y -q tig
RUN useradd -d /home/sh1 -s /bin/bash -g root -G sudo -p sh1 sh1

RUN mkdir -p /home/sh1/jupyter_server
ADD requirements.txt /home/sh1/jupyter_server/
WORKDIR /home/sh1/jupyter_server
RUN chown sh1:root /home/sh1/jupyter_server/
RUN chown sh1:root /home/sh1/jupyter_server/requirements.txt
USER sh1
#RUN python3 -m venv venv
#CMD source venv/bin/activate
#CMD pip install -r requirements.txt
#CMD nohup jupyter notebook &
