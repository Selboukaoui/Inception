FROM debian:bullseye
RUN apt-get update -y && apt-get install -y curl
RUN curl -L https://github.com/portainer/portainer/releases/download/2.36.0/portainer-2.36.0-linux-amd64.tar.gz | tar -xz -C /
ENTRYPOINT ["/portainer/portainer"]