#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_XTERM=${RUN_XTERM:-yes}
VNC_SERVER_HOST=${VNC_SERVER_HOST:-localhost}
VNC_SERVER_PORT=${VNC_SERVER_PORT:-5900}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_XTERM in
  false|no|n|0)
    rm -f /app/conf.d/xterm.conf
    ;;
esac

cp /app/websockify.conf /app/conf.d/websockify.conf
sed -i "s/localhost/$VNC_SERVER_HOST/g" /app/conf.d/websockify.conf
sed -i "s/5900/$VNC_SERVER_PORT/g" /app/conf.d/websockify.conf

exec supervisord -c /app/supervisord.conf
