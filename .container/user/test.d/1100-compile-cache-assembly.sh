#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  CLANG_VERSION=$(clang -dumpversion | cut -d. -f1)

  # Verify sccache wrapper contains assembly bypass
  if ! grep -q '\*\.s)' /usr/local/lib/compile-cache/sccache/clang; then
    b19-log bad "LLVM" "$(_p "sccache wrapper missing assembly bypass (clang-%s)" "${CLANG_VERSION}")"
    exit 1
  fi

  # Verify ccache wrapper contains assembly bypass
  if ! grep -q '\*\.s)' /usr/local/lib/compile-cache/ccache/clang; then
    b19-log bad "LLVM" "$(_p "ccache wrapper missing assembly bypass (clang-%s)" "${CLANG_VERSION}")"
    exit 1
  fi

  b19-log good "LLVM" "$(_p "compile-cache assembly bypass verified (clang-%s)" "${CLANG_VERSION}")"
