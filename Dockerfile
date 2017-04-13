FROM debian:latest
MAINTAINER kim@conduct.no

ENV GIT_REPO git@github.com:ConductAS/identity-stack-dockerized.git
RUN ssh-keygen -b 2048 -t rsa  -q -N ""; mkdir -p /opt/repo; apt-get update; apt-get install -y git; git clone ENV:GIT_REPO /opt/repo;
VOLUME ["/opt/repo"]

CMD ["tail -f /var/log/dmesg"]
