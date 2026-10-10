#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORKBASE_SCORE=0
WORKBASE_TOTAL=0

check() {
  local name="$1"
  local cmd="$2"
  local expected="${3:-pass}"
  WORKBASE_TOTAL=$((WORKBASE_TOTAL + 1))

  if bash -lc "${cmd}" >/dev/null 2>&1; then
    echo "[PASS] ${name}"
    WORKBASE_SCORE=$((WORKBASE_SCORE + 1))
  else
    echo "[FAIL] ${name}"
    echo "  command: ${cmd}"
  fi
}

check "project root exists" "test -d '${APP_ROOT}'"
check "build script exists" "test -f '${APP_ROOT}/scripts/build.sh'"
check "bootstrap script exists" "test -f '${APP_ROOT}/scripts/bootstrap.sh'"
check "config file exists" "test -f '${APP_ROOT}/config/shell.env'"
check "version file exists" "test -f '${APP_ROOT}/VERSION'"
check "bin entry exists" "test -f '${APP_ROOT}/bin/ish-shell'"

printf '\n[workbase grade] score: %s/%s\n' "${WORKBASE_SCORE}" "${WORKBASE_TOTAL}"

if [[ ${WORKBASE_SCORE} -eq ${WORKBASE_TOTAL} ]]; then
  echo "[GRADE] PASS"
  exit 0
else
  echo "[GRADE] FAIL"
  exit 1
fi
