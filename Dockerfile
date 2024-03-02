# Start from the Loki base image
FROM grafana/loki:2.9.4

USER root

# Install Promtail
RUN apk add --no-cache curl unzip && \
    curl -fSL -o promtail.zip "https://github.com/grafana/loki/releases/download/v2.9.4/promtail-linux-amd64.zip" && \
    unzip promtail.zip && \
    chmod a+x promtail && \
    mv promtail /usr/local/bin

# Copy Loki and Promtail configuration files
COPY loki.yaml /etc/loki/local-config.yaml
COPY promtail.yaml /etc/promtail/promtail.yaml

# Start Loki and Promtail
CMD ["sh", "-c", "loki -config.file=/etc/loki/local-config.yaml & promtail -config.file=/etc/promtail/promtail.yaml"]