FROM ghcr.io/zeroclaw-labs/zeroclaw@sha256:08a937436387f74291880b2b36d32515a94997c984a1246d879a16f062803c6d
USER root
RUN apt-get update && apt-get install -y --no-install-recommends nginx && rm -rf /var/lib/apt/lists/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY startup.sh /usr/local/bin/dawnistic/start
RUN chmod 0555 /usr/local/bin/dawnistic/start /etc/nginx/nginx.conf \
    && mkdir -p /var/lib/nginx/body /var/lib/nginx/proxy /var/lib/nginx/fastcgi /var/lib/nginx/uwsgi /var/lib/nginx/scgi \
    && chown -R nobody:nogroup /var/lib/nginx
USER 65534:65534
ENTRYPOINT ["/usr/local/bin/dawnistic/start"]
