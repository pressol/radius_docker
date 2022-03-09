FROM ubuntu:latest
VOLUME /etc/raddb
VOLUME /etc/freeradius/3.0
RUN cat /etc/os-release | grep UBUNTU_CODENAME | sed -e "s/UBUNTU_CODENAME=//" | tee /tmp/CODENAME.txt
RUN cat /tmp/CODENAME.txt
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $(cat /tmp/CODENAME.txt) main restricted universe multiverse" | tee /etc/apt/source.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $(cat /tmp/CODENAME.txt)-updates main restricted universe multiverse" | tee --append /etc/apt/source.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt $(cat /tmp/CODENAME.txt)-backports main restricted universe multiverse" | tee --append /etc/apt/source.list
RUN echo "deb http://security.ubuntu.com/ubuntu $(cat /tmp/CODENAME.txt)-security main restricted universe multiverse" | tee --append /etc/apt/source.list
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install freeradius freeradius-mysql freeradius-utils -y 
EXPOSE 1812/udp
EXPOSE 1813/udp
RUN service enable freeradius
RUN service start freeradius.service
