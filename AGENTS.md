<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# b19/llvm

Docker image built on [b19/Ubuntu](../ubuntu/AGENTS.md)

LLVM/Clang toolchain base image used as builder for zig and other LLVM-based projects.

## Key facts

- Base: `b19/ubuntu/${B19_UBUNTU_SERIES}` (resolute by default)
- LLVM installed from `apt.llvm.org` (not Ubuntu main repos)
- Series: 22, 21, 20 — series 20 pins Ubuntu noble via `matrix.overrides`; 21/22 use the resolute default
- Image name: `b19/llvm-{series}`

## What it provides

- `clang`, `lld`, `lldb`, `clang-format`, `clang-tidy`, `clang-tools`, `libc++-dev`, `libc++abi-dev`
- Versioned alternatives registered
- `sccache` intercepts `clang`/`clang++`
- Probe-selected CFLAGS/LDFLAGS (same mechanism as gcc)
- `get-llvm-version` anchors its regular expression to `clang version` via lookbehind: apt.llvm.org snapshot builds embed a dotted build timestamp in the version banner’s parenthetical, which an unanchored `\d+(?:\.\d+)+` also matches on the same line, leaking a second line into the command’s output

## Inheritable hooks

`compile-llvm/` hooks are `.i.` — downstream `compile-llvm` stages inherit: APT cacher, `setup-build`, sccache stats.

## Templates

Both `common.apt.deps` and the apt sources list are `.j2` (Jinja2) templates — rendered at build time by `minijinja-cli --env` (hook: `build.d/base/pre/200-setup-sources.sh`). Variables: `{{ ENV.B19_LLVM_SERIES }}`, `{{ ENV.DISTRIB_CODENAME }}`, `{{ ENV.TARGETARCH }}`. GPG key fetched via `b19-fetch` (hash-verified).

## Documentation

- [Available make targets](@docs/MAKEFILE.md)
- [Known caveats and limitations](@docs/caveats.md)
- [Completed features](@docs/done.md)
- [Project fit and alignment](@docs/fit.md)
- [Project goals](@docs/goal.md)
- [Future roadmap](@docs/roadmap.md)
