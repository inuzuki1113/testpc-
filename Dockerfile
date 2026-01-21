# ベースイメージ
FROM ubuntu:22.04

# 環境変数
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV USER=root

# 必要最小限のパッケージをインストール（止まりにくい）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xfce4 xfce4-goodies \
        tigervnc-standalone-server \
        git python3-minimal python3-pip \
        x11vnc xvfb wget curl nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# NoVNC をインストール
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

# VNC ディレクトリと xstartup 設定
RUN mkdir -p /root/.vnc
RUN echo -e "#!/bin/bash\nstartxfce4 &" > /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# ポートを公開（Render が割り当てるポートを使用）
EXPOSE 5901 6080

# 起動スクリプト
CMD /usr/bin/Xvfb :1 -screen 0 1280x720x24 & \
    /usr/bin/tigervncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None && \
    /opt/noVNC/utils/launch.sh --vnc localhost:5901 --listen $PORT
