# Start from the Loki base image
FROM grafana/loki:2.9.4

USER root

# Install Promtail
RUN apk add --no-cache curl unzip && \
    curl -fSL --output promtail.zip "https://github.com/grafana/loki/releases/download/v2.9.4/promtail-linux-amd64.zip" && \
    unzip promtail.zip && \
    chmod a+x promtail-linux-amd64 && \
    mv promtail-linux-amd64 /usr/local/bin

# Copy Loki and Promtail configuration files
COPY loki.yaml /etc/loki/config.yaml
COPY promtail.yaml /etc/promtail/config.yml

# Start Loki and Promtail
CMD ["sh", "-c", "loki -config.file=/etc/loki/config.yaml & promtail -config.file=/etc/promtail/config.yml"]