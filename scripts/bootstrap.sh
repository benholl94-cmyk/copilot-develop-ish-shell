#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

mkdir -p "${APP_ROOT}/build" \
         "${APP_ROOT}/logs" \
         "${APP_ROOT}/workspace" \
         "${APP_ROOT}/bin" \
         "${APP_ROOT}/config"

if [[ -f "${APP_ROOT}/config/shell.env" ]]; then
  # shellcheck disable=SC1090
  source "${APP_ROOT}/config/shell.env"
fi

chmod +x "${APP_ROOT}/bin/"*.sh 2>/dev/null || true
chmod +x "${APP_ROOT}/scripts/"*.sh 2>/dev/null || true

echo "[bootstrap] app root: ${APP_ROOT}"
echo "[bootstrap] build dir: ${APP_ROOT}/build"
echo "[bootstrap] logs dir: ${APP_ROOT}/logs"
echo "[bootstrap] workspace: ${APP_ROOT}/workspace"
echo "[bootstrap] completed successfully"
