<!--
SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>

SPDX-License-Identifier: MIT
-->

# Інструментальний ланцюжок LLVM/Clang з apt.llvm.org із вибором серії

- Clang, LLD, LLDB, clang-format, clang-tidy і clang-tools встановлюються з upstream-репозиторію `apt.llvm.org` (а не з Ubuntu main), із вибором серії (22, 21) через `B19_LLVM_SERIES`.
- GPG-ключ репозиторію завантажується з перевіркою SHA-512, а список джерел APT — це шаблон Jinja2, який розв’язується під час збирання з кодовим ім’ям, серією та архітектурою.
- Містить заголовки розробки libc++ і libc++abi, що дозволяє C++-проєктам лінкуватися зі стандартною бібліотекою LLVM.
- Усі версіоновані бінарні файли реєструються як типові системні через `update-alternatives`.
- Постачається повний інструментальний ланцюжок збирання: cmake, ninja-build, binutils, make, pkg-config і ccache.
