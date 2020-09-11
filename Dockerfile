FROM ubuntu:18.04
RUN apt-get update && apt-get install -y -q  sudo curl build-essential python3.7 python3-venv python3.7-dev python3.7-venv openssh-server

RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
RUN wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
RUN apt install ./cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
RUN wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
RUN apt install ./nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
RUN apt update
RUN apt install -y cuda9.0 cuda-cublas-9-0 cuda-cufft-9-0 cuda-curand-9-0 \
    cuda-cusolver-9-0 cuda-cusparse-9-0 libcudnn7=7.2.1.38-1+cuda9.0 \
            libnccl2=2.2.13-1+cuda9.0 cuda-command-line-tools-9-0

ENV CUDA_HOME="/usr/local/cuda-9.0"
ENV LD_LIBRARY_PATH="/usr/local/cuda-9.0/lib64"
RUN apt-get update ; apt-get upgrade; apt-get install -y -q octave liboctave-dev python-sympy
RUN apt-get install -y -q vim tig
RUN useradd -d /home/sh1 -s /bin/bash -g root -G sudo -p sh1 sh1
RUN echo "sh1:sh1" | chpasswd

RUN mkdir -p /home/sh1/jupyter_server
ADD requirements.txt /home/sh1/jupyter_server/
WORKDIR /home/sh1/jupyter_server
ADD project-211906-88503801d795.json  /home/sh1/jupyter_server
ADD cloud_sql_proxy /home/sh1/jupyter_server
ADD start.sh /home/sh1/jupyter_server
RUN chmod 755 start.sh
RUN chmod 755 cloud_sql_proxy

RUN chown sh1:root -R /home/sh1/
USER sh1
RUN python3.7 -m venv venv
RUN /bin/bash -c "source venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"
CMD /bin/bash  start.sh
