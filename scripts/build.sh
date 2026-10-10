#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-${APP_ROOT}/build}"
APP_NAME="${APP_NAME:-ish-shell}"
VERSION_FILE="${APP_ROOT}/VERSION"
TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

mkdir -p "${BUILD_DIR}"

if [[ -f "${VERSION_FILE}" ]]; then
  APP_VERSION="$(tr -d '\r\n' < "${VERSION_FILE}")"
else
  APP_VERSION="1.0.0-production"
fi

cat > "${BUILD_DIR}/${APP_NAME}.build" <<EOF
App Name: ${APP_NAME}
Version: ${APP_VERSION}
Build Timestamp: ${TIMESTAMP}
Build Root: ${APP_ROOT}
Status: Production Ready
EOF

echo "[build] artifact created: ${BUILD_DIR}/${APP_NAME}.build"
