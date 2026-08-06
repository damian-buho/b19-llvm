#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

  set -eou pipefail

  clang      --version
  clang++    --version
  cmake      --version
  ninja      --version
  pkg-config --version
