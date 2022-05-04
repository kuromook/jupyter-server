FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

# use only one GPU 
ENV CUDA_VISIBLE_DEVICES=0
RUN apt-key del 7fa2af80
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update
RUN apt-get install -y --no-install-recommends wget
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb 
RUN  dpkg -i cuda-keyring_1.0-1_all.deb

RUN apt-get update -y && apt-get install -y software-properties-common
RUN apt-get install -y -q  sudo curl build-essential python3.7 python3-venv python3.7-dev python3.7-venv openssh-server
RUN apt-get update ; apt-get upgrade; apt-get install -y -q octave liboctave-dev python-sympy

RUN apt-get install -y -q vim tig
RUN add-apt-repository ppa:kelleyk/emacs
RUN apt-get update; apt install -y emacs26

RUN useradd -d /home/sh1 -s /bin/bash -g root -G sudo -p sh1 sh1
RUN echo "sh1:sh1" | chpasswd

RUN mkdir -p /home/sh1/jupyter_server
ADD requirements.txt /home/sh1/jupyter_server/
WORKDIR /home/sh1/jupyter_server
ADD start.sh /home/sh1/jupyter_server
RUN chmod 755 start.sh
RUN chown sh1:root -R /home/sh1/

USER sh1
RUN python3 -m venv venv
RUN /bin/bash -c "source venv/bin/activate && pip install pip==19.0.1 && pip install -r requirements.txt"
CMD /bin/bash  start.sh
