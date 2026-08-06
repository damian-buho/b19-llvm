<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# LLVM/Clang toolchain from apt.llvm.org with series selection

- Clang, LLD, LLDB, clang-format, clang-tidy, and clang-tools installed from the upstream `apt.llvm.org` repository (not Ubuntu main), with series selection (22, 21) via `B19_LLVM_SERIES`.
- The repository GPG key is fetched with SHA-512 verification, and the APT sources list is a Jinja2 template resolved at build time with codename, series, and architecture.
- Ships libc++ and libc++abi development headers, enabling C++ projects to link against LLVM’s standard library.
- All versioned binaries are registered as system defaults via `update-alternatives`.
- Full build toolchain included: cmake, ninja-build, binutils, make, pkg-config, and ccache.
