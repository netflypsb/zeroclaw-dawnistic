#!/bin/sh
# Start nginx first (as nobody, port 8081 in front of the gateway on 42617).
# The Zeroclaw gateway binds loopback only by default, so nginx also needs
# `ZEROCLAW_gateway__host=0.0.0.0` — no, wait: gateway only needs loopback now.
set -e
nginx -t -c /etc/nginx/nginx.conf 2>&1 || { echo "[dawnistic] nginx config invalid; NOT starting"; nginx -T 2>&1 | tail -5; }
nginx -c /etc/nginx/nginx.conf &
exec zeroclaw gateway
