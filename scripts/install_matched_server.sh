#!/usr/bin/env bash
set -euo pipefail

BINARY="${1:-./olcrtc-linux-amd64}"
TARGET="/opt/whitelistvpn/olcrtc"
SERVICE="whitelistvpn-olcrtc"

if [[ ! -f "$BINARY" ]]; then
  echo "Не найден бинарник: $BINARY" >&2
  exit 1
fi

if [[ ! -f /opt/whitelistvpn/server.yaml ]]; then
  echo "Не найден /opt/whitelistvpn/server.yaml" >&2
  exit 1
fi

STAMP="$(date +%Y%m%d_%H%M%S)"

systemctl stop "$SERVICE"

if [[ -f "$TARGET" ]]; then
  cp -a "$TARGET" "${TARGET}.backup_${STAMP}"
fi

install -m 0755 "$BINARY" "$TARGET"
systemctl start "$SERVICE"

sleep 3

systemctl status "$SERVICE" --no-pager -l
journalctl -u "$SERVICE" -n 40 --no-pager -o cat
