FROM ubuntu:16.04
RUN apt-get update && apt-get install -y -q  sudo curl build-essential python3-dev python3-venv openssh-server

RUN apt-get install -y -q vim tig
RUN useradd -d /home/sh1 -s /bin/bash -g root -G sudo -p sh1 sh1
RUN echo "sh1:sh1" | chpasswd

RUN mkdir -p /home/sh1/jupyter_server
ADD requirements.txt /home/sh1/jupyter_server/
WORKDIR /home/sh1/jupyter_server
ADD project-211906-88503801d795.json /home/sh1/jupyter_server
ADD cloud_sql_proxy /home/sh1/jupyter_server
ADD start.sh /home/sh1/jupyter_server
RUN chmod 755 start.sh
RUN chmod 755 cloud_sql_proxy
RUN chown sh1:root -R /home/sh1/
USER sh1
RUN python3 -m venv venv
RUN /bin/bash -c "source venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"
CMD /bin/bash  start.sh
