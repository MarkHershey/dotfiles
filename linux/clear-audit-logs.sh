#!/usr/bin/env bash
set -euo pipefail

AUDIT_DIR="/var/log/audit"
AUDIT_CONF="/etc/audit/auditd.conf"

# Require root (avoid noisy permission-denied when not sudo)
if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "This script must be run as root (try: sudo $0)"; exit 1
fi

# Sanity checks
if [[ ! -d "$AUDIT_DIR" ]]; then
  echo "Audit directory $AUDIT_DIR not found"; exit 0
fi
# Refuse dangerous targets
AUDIT_DIR_REAL="$(readlink -f "$AUDIT_DIR")"
if [[ -z "$AUDIT_DIR_REAL" || "$AUDIT_DIR_REAL" == "/" || "$AUDIT_DIR_REAL" == "/var/log" ]]; then
  echo "Refusing to operate on $AUDIT_DIR_REAL"; exit 1
fi

# Determine active audit log file from auditd.conf (fallback to default)
ACTIVE_LOG="$(awk -F= '
  $1 ~ /^[[:space:]]*log_file[[:space:]]*$/ {
    gsub(/[[:space:]]/, "", $2); print $2; exit
  }
' "$AUDIT_CONF" 2>/dev/null || true)"

if [[ -z "${ACTIVE_LOG:-}" ]]; then
  ACTIVE_LOG="$AUDIT_DIR_REAL/audit.log"
fi
ACTIVE_LOG_REAL="$(readlink -f "$ACTIVE_LOG" || true)"

# Ensure ACTIVE_LOG is under AUDIT_DIR
case "$ACTIVE_LOG_REAL" in
  "$AUDIT_DIR_REAL"/*) ;;
  *) ACTIVE_LOG_REAL="" ;;  # treat as unknown; we won't special-case it
esac

# 1) Delete all *other* files under /var/log/audit (stay on same filesystem)
find "$AUDIT_DIR_REAL" -xdev -type f \
  ${ACTIVE_LOG_REAL:+ ! -samefile "$ACTIVE_LOG_REAL"} \
  -exec rm -f -- {} +

# 2) Truncate the active log (if it lives under /var/log/audit)
if [[ -n "${ACTIVE_LOG_REAL:-}" && -f "$ACTIVE_LOG_REAL" ]]; then
  : > "$ACTIVE_LOG_REAL" || truncate -s 0 "$ACTIVE_LOG_REAL"
fi

# 3) Remove any now-empty subdirectories (but keep the top-level directory)
#    NOTE: move -mindepth before tests to avoid find(1) warning
find "$AUDIT_DIR_REAL" -xdev -mindepth 1 -type d -empty -delete

exit 0
