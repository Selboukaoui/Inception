FROM debian:bookworm
RUN apt-get update -y && apt-get install redis-server -y
ENTRYPOINT ["redis-server", "--bind", "0.0.0.0","--protected-mode", "no", "--maxmemory", "256mb", "--maxmemory-policy", "allkeys-lru"]