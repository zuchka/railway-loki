# Start from the Loki base image
FROM grafana/loki:2.9.4

# Install Promtail
RUN apk add --no-cache curl && \
    curl -fSL -o promtail.gz "https://github.com/grafana/loki/releases/download/v2.9.4/promtail-linux-amd64.zip" && \
    gunzip promtail.gz && \
    chmod a+x promtail && \
    mv promtail /usr/local/bin

# Copy Loki and Promtail configuration files
COPY loki.yaml /etc/loki/local-config.yaml
COPY promtail.yaml /etc/promtail/promtail.yaml

# Start Loki and Promtail
CMD ["sh", "-c", "loki -config.file=/etc/loki/local-config.yaml & promtail -config.file=/etc/promtail/promtail.yaml"]







# FROM grafana/loki:2.9.4

# # expose the Loki server port
# EXPOSE 9090

# COPY loki.yaml /etc/loki/local-config.yaml

# CMD ["-config.file=/etc/loki/local-config.yaml"]







# COPY prometheus.yml /etc/prometheus/prometheus.yml

# # expose the Prometheus server port
# EXPOSE 9090

# # set the entrypoint command
# USER root
# ENTRYPOINT [ "/bin/prometheus" ]
# CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
#              "--storage.tsdb.path=/prometheus", \
#              "--storage.tsdb.retention=365d", \
#              "--web.console.libraries=/usr/share/prometheus/console_libraries", \
#              "--web.console.templates=/usr/share/prometheus/consoles", \
#              "--web.external-url=http://localhost:9090", \
#              "--log.level=info"]