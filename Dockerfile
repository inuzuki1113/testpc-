RUN rm -f /root/.vnc/xstartup && \
    mkdir -p /root/.vnc && \
    printf '#!/bin/sh\nexec xterm &\n' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup
