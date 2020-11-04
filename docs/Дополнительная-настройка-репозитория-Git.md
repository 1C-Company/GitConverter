По умолчанию создается файл настроек `.gitattributes` в который добавлены настройки бинарных файлов:

```
*.bin binary
*.axdt binary
*.addin binary
```

По умолчанию создается файл исключений `.gitignore`, в который добавляются файлы `DumpFilesIndex.txt` и `ConfigDumpInfo.xml` - не требуемые для работы с исходными файлами конфигурации 1С.

Если репозиторий был создан с помощью кнопки в карточке хранилища, в локальный конфиг репозитория добавляются настройки для более комфортной работы:

```bash
git config --local core.quotepath false
git config --local gui.encoding utf-8
git config --local i18n.commitEncoding utf-8
git config --local diff.renameLimit 1
git config --local diff.renames false
```
