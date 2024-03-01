# FROM grafana/promtail:2.9.4

# # expose the Promtail server port
# EXPOSE 9080

# COPY promtail.yaml /etc/promtail/config.yml
# # VOLUME /var/log:/var/log
# CMD ["-config.file=/etc/promtail/config.yml"]

FROM grafana/loki:2.9.4

# expose the Loki server port
EXPOSE 3100

COPY loki.yaml /etc/loki/local-config.yaml

CMD ["-config.file=/etc/loki/local-config.yaml"]







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