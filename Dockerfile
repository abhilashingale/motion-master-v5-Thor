FROM ubuntu:24.04

COPY bin/motion-master_5.6.1-1_arm64.deb /tmp/motion-master.deb
RUN apt-get update \
 && apt-get install -y --no-install-recommends /tmp/motion-master.deb \
 && rm -rf /tmp/motion-master.deb /var/lib/apt/lists/*

WORKDIR /usr/lib/motion-master

# Defaults; override from docker-compose.yml. MM_MAC is the MAC address of the
# EtherCAT network interface and must be set.
ENV MM_DRV=soem \
    MM_MAC= \
    MM_REQ_RES_PORT=63524 \
    MM_PUB_SUB_PORT=63525 \
    MM_PDO_MODE=monitor \
    MM_IPS=

EXPOSE 63524 63525
ENTRYPOINT ["/bin/sh", "-c", "exec motion-master --driver=\"$MM_DRV\" --mac=\"$MM_MAC\" --req-res-port=\"$MM_REQ_RES_PORT\" --pub-sub-port=\"$MM_PUB_SUB_PORT\" --pdo-mode=\"$MM_PDO_MODE\" ${MM_IPS:+--ips=\"$MM_IPS\"} \"$@\"", "motion-master"]
