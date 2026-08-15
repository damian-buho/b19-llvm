<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Cadena de herramientas LLVM/Clang desde apt.llvm.org con selección de serie

- Clang, LLD, LLDB, clang-format, clang-tidy y clang-tools se instalan desde el repositorio upstream `apt.llvm.org` (no desde Ubuntu main), con selección de serie (22, 21) mediante `B19_LLVM_SERIES`.
- La clave GPG del repositorio se descarga con verificación SHA-512, y la lista de fuentes APT es una plantilla Jinja2 resuelta en tiempo de compilación con codename, serie y arquitectura.
- Incluye las cabeceras de desarrollo de libc++ y libc++abi, lo que permite a los proyectos C++ enlazar contra la biblioteca estándar de LLVM.
- Todos los binarios versionados se registran como predeterminados del sistema mediante `update-alternatives`.
- Cadena de herramientas de compilación completa incluida: cmake, ninja-build, binutils, make, pkg-config y ccache.
