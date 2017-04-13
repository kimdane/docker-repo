FROM debian:latest
MAINTAINER kim@conduct.no

ENV GIT_REPO https://github.com/ConductAS/identity-stack-dockerized.git
RUN mkdir -p /opt/repo; apt-get update; apt-get install -y git; git clone ENV:GIT_REPO /opt/repo;
VOLUME ["/opt/repo"]

CMD ["tail -f /var/log/dmesg"]
