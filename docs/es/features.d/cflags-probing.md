<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Flags de optimización específicos de cada arquitectura con sondeo en tiempo de compilación

- CFLAGS curados por arquitectura: amd64 incluye 45 objetivos ISA (AVX2, FMA, BMI2, SSE4, POPCNT, CRC32) más `-O3` con secciones de funciones y datos; arm64 apunta a `-O3`.
- LDFLAGS endurecidos en seguridad en ambas arquitecturas: RELRO, resolución inmediata de símbolos (`-z now`) y, en amd64, eliminación de secciones muertas (`--gc-sections`) y stripping completo (`--strip-all`).
- Cada CFLAG se sondea al inicio de la compilación compilando un programa de prueba con Clang: solo sobreviven los flags que soportan la versión real de Clang y la CPU objetivo; los no soportados se registran en el log y se descartan. Los LDFLAGS se aplican tal cual, sin sondeo.
- Los flags sondeados se exportan como `CFLAGS`, `CXXFLAGS` y `LDFLAGS` para toda la compilación posterior.
