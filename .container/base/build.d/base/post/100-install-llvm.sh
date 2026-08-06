#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT


  # LLVM packages installed via common.apt.deps
  # Repository configured by pre/200-setup-sources.sh
  # Set alternatives for version-suffixed binaries

  b19-run "LLVM" "$(_p "Setting clang alternatives for version %s" "${B19_LLVM_SERIES}")" --        \
    update-alternatives --install /usr/bin/clang clang "/usr/bin/clang-${B19_LLVM_SERIES}" 100      \
      --slave /usr/bin/clang++ clang++ "/usr/bin/clang++-${B19_LLVM_SERIES}"

  b19-run "LLVM" "$(_p "Setting lld alternative for version %s" "${B19_LLVM_SERIES}")" --     \
    update-alternatives --install /usr/bin/lld lld "/usr/bin/lld-${B19_LLVM_SERIES}" 100

  b19-run "LLVM" "$(_p "Setting lldb alternative for version %s" "${B19_LLVM_SERIES}")" --      \
    update-alternatives --install /usr/bin/lldb lldb "/usr/bin/lldb-${B19_LLVM_SERIES}" 100

  b19-run "LLVM" "$(_p "Setting clang-format alternative for version %s" "${B19_LLVM_SERIES}")" --      \
    update-alternatives --install /usr/bin/clang-format clang-format "/usr/bin/clang-format-${B19_LLVM_SERIES}" 100

  b19-run "LLVM" "$(_p "Setting clang-tidy alternative for version %s" "${B19_LLVM_SERIES}")" --      \
    update-alternatives --install /usr/bin/clang-tidy clang-tidy "/usr/bin/clang-tidy-${B19_LLVM_SERIES}" 100

  b19-run "LLVM" "$(_p "Setting llvm-config alternative for version %s" "${B19_LLVM_SERIES}")" --     \
    update-alternatives --install /usr/bin/llvm-config llvm-config "/usr/bin/llvm-config-${B19_LLVM_SERIES}" 100

  b19-log good "LLVM" "$(_p "LLVM/Clang %s alternatives set" "${B19_LLVM_SERIES}")"

  mkdir -p "/deps/llvm/${B19_LLVM_SERIES}"
  llvm-config --version > "/deps/llvm/${B19_LLVM_SERIES}/version.deps"
