FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server tigervnc-common \
    novnc websockify \
    xterm dbus-x11 \
    && apt clean

RUN mkdir -p /root/.vnc && \
    printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nexec startxfce4\n' \
    > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

EXPOSE 6080

CMD bash -c "\
    vncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None && \
    websockify --web=/usr/share/novnc/ 6080 localhost:5901 \
"
