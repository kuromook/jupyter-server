# jupyter_server
  
sudo docker build -t jns .  
sudo docker run -itv /home/sh1/notebook:/home/sh1/notebook -p 9999:9999 IMAGE ID /bin/bash  

start.sh 内のpasswordは適宜変更のこと   
TODO ubuntu 18.04 , python 3.7
