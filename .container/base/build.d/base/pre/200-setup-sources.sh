#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  # shellcheck source=/dev/null
  . b19-i18n

  set -a
  # shellcheck source=/dev/null
  . /etc/lsb-release
  set +a

  eval "$(b19-resolve-dep llvm-key)"

  b19-fetch "LLVM" "${M6E_UPSTREAM__URL}" "${M6E_UPSTREAM__FILE}" "${M6E_UPSTREAM__HASH}"

  GPG_SRC="${B19_TEMP_PATH}/${M6E_UPSTREAM__FILE}"
  GPG_DST="/etc/apt/trusted.gpg.d/llvm-snapshot.asc"
  if ! grep -qP '^-----BEGIN PGP' "${GPG_SRC}" 2>/dev/null; then
    b19-log bad "LLVM" "$(_p "Downloaded file does not look like an ASCII-armored PGP key: %s" "${GPG_SRC}")"
    exit 1
  fi
  mv "${GPG_SRC}" "${GPG_DST}"

  b19-log good "LLVM" "$(_ "Downloaded LLVM GPG key")"

  J2_FILE="/etc/apt/sources.list.d/llvm.sources.j2"
  OUTPUT_FILE="/etc/apt/sources.list.d/llvm.sources"
  b19-run "LLVM" "$(_p "Render %s" "${OUTPUT_FILE}")" --      \
    minijinja-cli --autoescape none --env "${J2_FILE}" -o "${OUTPUT_FILE}"

  J2_FILE="/deps/common.apt.deps.j2"
  OUTPUT_FILE="/deps/common.apt.deps"
  b19-run "LLVM" "$(_p "Render %s" "${OUTPUT_FILE}")" --      \
    minijinja-cli --autoescape none --env "${J2_FILE}" -o "${OUTPUT_FILE}"

  b19-run "LLVM" "$(_p "Remove %s" "*.j2")" --      \
    rm /etc/apt/sources.list.d/llvm.sources.j2 /deps/*.j2

  b19-log good "LLVM" "$(_p "LLVM repository configured for %s and %s" "${DISTRIB_CODENAME}" "${B19_LLVM_SERIES}")"
