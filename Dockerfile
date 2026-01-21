FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xfce4 xfce4-goodies \
        xfce4-session \
        dbus-x11 \
        tigervnc-standalone-server \
        git python3-minimal python3-pip \
        wget curl nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# NoVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

# VNC xstartup（echo -e は使わない）
RUN mkdir -p /root/.vnc && \
    printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec startxfce4 &\n' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

EXPOSE 6080

CMD rm -f /tmp/.X1-lock && \
    tigervncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None && \
    /opt/noVNC/utils/launch.sh --vnc localhost:5901 --listen $PORT
