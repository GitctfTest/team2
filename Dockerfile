FROM ubuntu:18.04
#debian:latest

# =========Install your package=========
WORKDIR /tmp
RUN apt-get -y update
RUN apt-get install -y gcc
RUN apt install -y make
RUN apt install -y xinetd
# ======================================

RUN mkdir -p /var/ctf
COPY flag /var/ctf/

# ======Build and run your service======
ADD /service /src
COPY echo_service /etc/xinetd.d/

RUN cd /src; make
WORKDIR /src

RUN echo "echo_service 4000/tcp" >> /etc/services

RUN service xinetd restart
CMD xinetd -dontfork
