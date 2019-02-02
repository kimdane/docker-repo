FROM debian:latest
MAINTAINER kimdane

ENV GIT_REPO https://github.com/ConductAS/identity-stack-dockerized.git

#RUN mkdir -p /opt/repo; apt-get update; apt-get install -y git; 
#RUN git clone $GIT_REPO /opt/repo;
WORKDIR /opt/repo

VOLUME ["/opt/repo"]

RUN ./modify-files.sh
CMD ["tail -f /var/log/*"]
