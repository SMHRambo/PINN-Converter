FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    7zip \
    acl \
    fdisk \
    file \
    jq \
    libarchive-tools \
    mount \
    util-linux \
    xz-utils 

RUN mkdir -p /opt/pinn
RUN mkdir -p /opt/pinn/os
COPY pinn-converter.sh /opt/pinn/

WORKDIR /opt/pinn
ENTRYPOINT ["/opt/pinn/pinn-converter.sh"]
