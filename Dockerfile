# Start from the Loki base image
FROM grafana/loki:2.9.4

USER root

# Copy Loki and Promtail configuration files
COPY loki.yaml /etc/loki/local-config.yaml
COPY promtail.yaml /etc/promtail/config.yml

# Install Promtail
RUN apk add --no-cache curl unzip && \
    curl -fSL --output promtail.zip "https://github.com/grafana/loki/releases/download/v2.9.4/promtail-linux-amd64.zip" && \
    unzip promtail.zip && \
    chmod a+x promtail-linux-amd64 && \
    mv promtail-linux-amd64 /usr/local/bin
    
# Start Loki and Promtail
# CMD ["-config.file=/etc/loki/local-config.yaml"]
CMD ["sh", "-c", "loki -config.file=/etc/loki/local-config.yaml & promtail-linux-amd64 -config.file=/etc/promtail/config.yml"]


# FROM grafana/loki:2.9.4

# # expose the Loki server port
# EXPOSE 9090

# COPY loki.yaml /etc/loki/local-config.yaml

# CMD ["-config.file=/etc/loki/local-config.yaml"]