#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  # shellcheck source=/dev/null
  . b19-i18n

  TESTDIR=$(mktemp -d)
  trap 'rm -rf "${TESTDIR}"' EXIT

  # C with clang
  CLANG_VERSION=$(clang -dumpversion | cut -d. -f1)
  echo 'int main() { return 0; }' > "${TESTDIR}/test.c"
  clang -o "${TESTDIR}/test_clang" "${TESTDIR}/test.c"
  chmod +x "${TESTDIR}/test_clang"
  "${TESTDIR}/test_clang"
  b19-log good "LLVM" "$(_p "clang-%s compile test passed" "${CLANG_VERSION}")"

  # C++ with clang++
  echo '#include <iostream>
int main() { std::cout << "ok" << std::endl; return 0; }' > "${TESTDIR}/test.cpp"
  clang++ -stdlib=libc++ -o "${TESTDIR}/test_clangpp" "${TESTDIR}/test.cpp"
  chmod +x "${TESTDIR}/test_clangpp"
  "${TESTDIR}/test_clangpp"
  b19-log good "LLVM" "$(_p "clang++-%s compile test passed" "${CLANG_VERSION}")"

  # cmake + ninja
  CMAKE_VERSION=$(cmake --version | head -n1 | grep -oP '\d+\.\d+')
  NINJA_VERSION=$(ninja --version 2>/dev/null || echo "unknown")
  mkdir "${TESTDIR}/build"
  cat > "${TESTDIR}/CMakeLists.txt" << 'EOF'
cmake_minimum_required(VERSION 3.10)
project(CompileTest C)
add_executable(test_cmake test.c)
EOF
  cmake -G Ninja -DCMAKE_C_COMPILER=/usr/bin/clang -S "${TESTDIR}" -B "${TESTDIR}/build"
  ninja -C "${TESTDIR}/build"
  "${TESTDIR}/build/test_cmake"
  b19-log good "LLVM" "$(_p "cmake %s + ninja %s build test passed" "${CMAKE_VERSION}" "${NINJA_VERSION}")"
