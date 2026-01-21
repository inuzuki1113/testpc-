FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xfce4 xfce4-goodies \
        tigervnc-standalone-server \
        git python3-minimal python3-pip \
        wget curl nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

RUN mkdir -p /root/.vnc && \
    echo -e "#!/bin/bash\nstartxfce4 &" > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

EXPOSE 6080

CMD rm -f /tmp/.X1-lock && \
    /usr/bin/tigervncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None && \
    /opt/noVNC/utils/launch.sh --vnc localhost:5901 --listen $PORT
