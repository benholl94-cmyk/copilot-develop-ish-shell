#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CODEBASE_SCORE=0
CODEBASE_TOTAL=0

check() {
  local name="$1"
  local cmd="$2"
  CODEBASE_TOTAL=$((CODEBASE_TOTAL + 1))

  if bash -lc "${cmd}" >/dev/null 2>&1; then
    echo "[PASS] ${name}"
    CODEBASE_SCORE=$((CODEBASE_SCORE + 1))
  else
    echo "[FAIL] ${name}"
    echo "  command: ${cmd}"
  fi
}

check "shell syntax valid" "bash -n '${APP_ROOT}/bin/ish-shell'"
check "bootstrap script syntax valid" "bash -n '${APP_ROOT}/scripts/bootstrap.sh'"
check "build script syntax valid" "bash -n '${APP_ROOT}/scripts/build.sh'"
check "workbase grader syntax valid" "bash -n '${APP_ROOT}/scripts/grade-workbase.sh'"
check "codebase grader syntax valid" "bash -n '${APP_ROOT}/scripts/grade-codebase.sh'"
check "VERSION file readable" "test -r '${APP_ROOT}/VERSION'"

printf '\n[codebase grade] score: %s/%s\n' "${CODEBASE_SCORE}" "${CODEBASE_TOTAL}"

if [[ ${CODEBASE_SCORE} -eq ${CODEBASE_TOTAL} ]]; then
  echo "[GRADE] PASS"
  exit 0
else
  echo "[GRADE] FAIL"
  exit 1
fi
