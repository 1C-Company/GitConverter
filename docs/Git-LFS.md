Для увеличения быстродействия репозитория Git можно использовать расширение __git lfs__ (https://git-lfs.github.com)

Если используется сервер репозиториев Git, необходимо убедиться, что он поддерживает это расширение и включить настройки для проекта. Например, GitLab, GitHub, BitBucket - поддерживают.

Выполнить начальную настройку репозитория до выполнения первого коммита:

```bash
git lfs install
```

Включить отслеживание бинарных файлов конфигурации
```bash
git lfs track "*.cf"
git lfs track "*.bin"
git lfs track "*.png"
git lfs track "*.gif"
git lfs track "*.bmp"
git lfs track "*.jpg"
git lfs track "*.zip"
git lfs track "*.axdt"
git lfs track "*.addin"
git lfs track "*.oform"
```
В этом примере - все файлы конфигураций поставщиков, файлы макетов с "Двоичными данными" и картинки из конфигурации попадут в lfs.

Например, чтобы переносить в LFS только некоторые типы файлов с расширением `*.bin` можно включить отслеживание только шаблонов и модулей без исходного кода по маске:

```bash
git lfs track "*/Ext/Template.bin"
git lfs track "*/Ext/Module.bin"
```

Пример файла настроек репозитория:

```
﻿# Binary file extensions that should not be modified.
*.bin binary
*.axdt binary
*.addin binary
*.oform binary
# LFS
*.cf filter=lfs diff=lfs merge=lfs -text
*.bin filter=lfs diff=lfs merge=lfs -text
*.png filter=lfs diff=lfs merge=lfs -text
*.gif filter=lfs diff=lfs merge=lfs -text
*.bmp filter=lfs diff=lfs merge=lfs -text
*.jpg filter=lfs diff=lfs merge=lfs -text
*.zip filter=lfs diff=lfs merge=lfs -text
*.axdt filter=lfs diff=lfs merge=lfs -text
*.addin filter=lfs diff=lfs merge=lfs -text
*.oform filter=lfs diff=lfs merge=lfs -text
```
