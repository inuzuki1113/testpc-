FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    tigervnc-standalone-server \
    tigervnc-common \
    xterm \
    xvfb \
    fluxbox \
    novnc \
    websockify \
    git \
    ca-certificates \
    && apt-get clean

# xstartup を最小構成（超重要）
RUN rm -f /root/.vnc/xstartup && \
    mkdir -p /root/.vnc && \
    printf '#!/bin/sh\nexec xterm &\n' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

EXPOSE 5901 6080

CMD ["bash"]
