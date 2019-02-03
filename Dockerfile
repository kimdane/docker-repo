FROM debian:latest
MAINTAINER kimdane

ENV GIT_REPO https://github.com/ConductAS/identity-stack-dockerized.git

#RUN mkdir -p /opt/repo; apt-get update; apt-get install -y git; 
#RUN git clone $GIT_REPO /opt/repo;
WORKDIR /opt/repo

VOLUME ["/opt/repo"]

RUN apt-get update && apt-get install unzip && apt-get clean

ADD modify-files.sh /opt/modify-files.sh
RUN /opt/modify-files.sh
