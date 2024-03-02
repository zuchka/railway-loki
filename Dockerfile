# Start from the Ubuntu base image
FROM ubuntu:20.04

USER root

# Install necessary packages
RUN apt-get update && apt-get install -y curl unzip

# Download and install Loki
RUN curl -fSL --output loki.zip "https://github.com/grafana/loki/releases/download/v2.9.4/loki-linux-amd64.zip" && \
    unzip loki.zip && \
    chmod a+x loki-linux-amd64 && \
    mv loki-linux-amd64 /usr/local/bin

# Download and install Promtail
RUN curl -fSL --output promtail.zip "https://github.com/grafana/loki/releases/download/v2.9.4/promtail-linux-amd64.zip" && \
    unzip promtail.zip && \
    chmod a+x promtail-linux-amd64 && \
    mv promtail-linux-amd64 /usr/local/bin

# Copy Loki and Promtail configuration files
COPY loki.yaml /etc/loki/local-config.yaml
COPY promtail.yaml /etc/promtail/config.yml

# Start Loki and Promtail
CMD ["sh", "-c", "/usr/local/bin/loki-linux-amd64 --config.file=/etc/loki/local-config.yaml & /usr/local/bin/promtail-linux-amd64 --config.file=/etc/promtail/config.yml"]