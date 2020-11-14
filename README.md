# 1С:ГитКонвертер

Конфигурация предназначена для односторонней синхронизации хранилища конфигурации "1С:Предприятия" с репозиторием Git и последующим переходом на разработку в [1C:Enterprise Development Tools (1C:EDT)](http://v8.1c.ru/overview/release_EDT_17/) с сохранением истории.

## Основные возможности

* Конвертирование существующего хранилища конфигурации 1С в репозиторий Git в формате 1C:EDT
* Обновлять изменения из хранилища 1С в репозиторий Git
* Параллелизировать загрузку истории хранилища из копий хранилища
* Управление нагрузкой на сервер с помощью очередей
* Возможно "сращивать" историю в Git, если хранилище конфигураций "1С:Предприятия" обрезалось или начиналось заново.
* Создание корректной истории переименования объектов метаданных (см. [Как это работает](https://github.com/1C-Company/GitConverter/wiki/Как-это-работает#Коммит-в-git))
* Выгружать только изменения конфигурации. Доступно для Платформы 8.3.10 и выше, для версий ниже 8.3.15 требуется использовать "очереди"
* Создание сквозной истории изменений для "хранилищ исправительных версий" если вы используете [Технологию разветвленной разработки конфигураций](https://its.1c.ru/db/v8std#content:709:hdoc) или аналогичный процесс - хранилище версии можно загружать в "ветку" Git, получив сквозную историю в ветке.
* Возможность автоматически указывать Git теги при изменении версии конфигурации. 
* Поддержка конвертации разных хранилищ в разные ветки одного репозитория на различных версиях Платформы и различных версиях 1C:EDT.
* Поддержка конвертации хранилищ расширений конфигураций. Возможность связи с базовым проектом 1С:ГитКонвертера или независимо.

### Возможности добавляемые расширениями

Поставляемые расширения:
* [Версия Платформы Хранилища](https://github.com/1C-Company/GitConverter/wiki/Версия-Платформы-Хранилища) позволяет подклчаться к Хранилищу на версии, отличной от версии выгрузки.
* [Оптимизация выгрузки на 8.3.15](https://github.com/1C-Company/GitConverter/wiki/Оптимизация-выгрузки-на-8.3.15) позволяет для предыдущих версий 1С:Предприятия задействовать оптимизированный алгоритм, доступный с 8.3.15.

Сторонние расширения:
* [Конвертирование истории "Обычного приложения"](https://github.com/marmyshev/GitConverter-ordinary)
* `<Ждем ваших pull-request'ов>`

### Необходимые компоненты

* Конфигурацию можно запустить, используя 1C:Enterprise Development Tools 2020.6 (https://releases.1c.ru/project/DevelopmentTools10)
* Расширение 1C:Language Tool для локализации английского интерфейса (https://its.1c.ru/db/edtplugins#bookmark:languagetool:LanguageTool)
* Расширение 1C:SSL-support (поддержка разработки на основе 1С:БСП) (https://its.1c.ru/db/edtplugins#bookmark:sslsupport:SSLsupport)
* Платформа 1С:Предприятия 8.3.12 и выше (https://releases.1c.ru/project/Platform83)
* СУБД, поддерживаемая 1С:Предприятием
* OS Windows 7 или выше, ОС Linux и macOS - в бета-режиме.

### Сборка и установка проекта

Выполните команды в Linux:

```bash
git clone https://github.com/1C-Company/GitConverter.git
ring edt workspace export --workspace-location "${PWD}/w" --project "${PWD}/GitConverter/GitConverter" --configuration-files "${PWD}/xml"
1cv8 CREATEINFOBASE File=${PWD}/db
1cv8 DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="${PWD}/db" /LoadConfigFromFiles "${PWD}/xml" /UpdateDBCfg
1cv8 DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="${PWD}/db" /CreateDistributionFiles -cffile "${PWD}/1cv8.cf"
# Экспорт расширений
ring edt workspace export --workspace-location "${PWD}/w" --project "${PWD}/GitConverter/GitConverter.ВерсииПлатформыХранилища" --configuration-files "${PWD}/xml_e/ВерсииПлатформыХранилища"
ring edt workspace export --workspace-location "${PWD}/w" --project "${PWD}/GitConverter/GitConverter.ОптимизацияВыгрузки8315" --configuration-files "${PWD}/xml_e/ОптимизацияВыгрузки8315"
1cv8 DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="${PWD}/db" /LoadConfigFromFiles "${PWD}/xml_e" -AllExtensions /UpdateDBCfg
# Сохранение расширений
1cv8 DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="${PWD}/db" /DumpCfg "${PWD}/RepositoryPlatformVersions.cfe" -Extension "ВерсииПлатформыХранилища"
1cv8 DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="${PWD}/db" /DumpCfg "${PWD}/DumpOptimization8315.cfe" -Extension "ОптимизацияВыгрузки8315"
```

Выполните команды в Windows, указав корректный путь к версии 1С:

```cmd
git clone https://github.com/1C-Company/GitConverter.git
ring edt workspace export --workspace-location "%CD%/w" --project "%CD%/GitConverter/GitConverter" --configuration-files "%CD%/xml"
"C:\Program files\1cv8\8.3.12.1714\bin\1cv8" CREATEINFOBASE File=%CD%/db
"C:\Program files\1cv8\8.3.12.1714\bin\1cv8" DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="%CD%/db" /LoadConfigFromFiles "%CD%/xml" /UpdateDBCfg
"C:\Program files\1cv8\8.3.12.1714\bin\1cv8" DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="%CD%/db" /CreateDistributionFiles -cffile "%CD%/1cv8.cf"
:: Экспорт расширений
ring edt workspace export --workspace-location "%CD%/w" --project "%CD%/GitConverter/GitConverter.ВерсииПлатформыХранилища" --configuration-files "%CD%/xml_e/ВерсииПлатформыХранилища"
ring edt workspace export --workspace-location "%CD%/w" --project "%CD%/GitConverter/GitConverter.ОптимизацияВыгрузки8315" --configuration-files "%CD%/xml_e/ОптимизацияВыгрузки8315"
"C:\Program files\1cv8\8.3.12.1714\bin\1cv8" DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="%CD%/db" /LoadConfigFromFiles "%CD%/xml_e" -AllExtensions /UpdateDBCfg
:: Сохранение расширений
"C:\Program files\1cv8\8.3.12.1714\bin\1cv8" DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="%CD%/db" /DumpCfg "%CD%/RepositoryPlatformVersions.cfe" -Extension "ВерсииПлатформыХранилища"
"C:\Program files\1cv8\8.3.12.1714\bin\1cv8" DESIGNER /WA- /DisableStartupDialogs /IBConnectionString File="%CD%/db" /DumpCfg "%CD%/DumpOptimization8315.cfe" -Extension "ОптимизацияВыгрузки8315"
```

## Начальная настройка

[Без настройки - никак. См. Wiki](https://github.com/1C-Company/GitConverter/wiki/Начальная-настройка)

## Документация

* Справка в конфигурации 1С:ГитКонвертер
* Подсказки к полям и командам в конфигурации
* Документация в [Wiki](https://github.com/1C-Company/GitConverter/wiki) и [сценарии применения конфигурации](https://github.com/1C-Company/GitConverter/wiki/Сценарии-применения)

### Если что-то пошло не так (FAQ)

[См. примеры Wiki](https://github.com/1C-Company/GitConverter/wiki/Если-что-то-пошло-не-так-FAQ)

## Участие в проекте

Добро пожаловать! [См. правила в соответствующем разделе](CONTRIBUTING.md)

## Обновление с версии 1.0.4

**Внимание!**  Конвертация хранилища 1С в формат выгрузки xml 1С:Предприятия является [устаревшей функциональностью](https://github.com/1C-Company/GitConverter/wiki/Обновление-с-версии-1.0.4) и не доступна для новых настроек конвертации хранилища. 
Текущие настройки синхронизации хранилища, конвертирующие в формат выгрузки xml 1С:Предприятия работать не будут. Рекомендуется выполнить разовую конвертацию в формат 1C:EDT и продолжить синхронизацию в этом формате.  [См. Wiki](https://github.com/1C-Company/GitConverter/wiki/Конвертация-выгрузки-1С-Предприятия-в-формат-1C-Enterprise-Development-Tools)

Функциональность конвертирования в формат xml 1С:Предприятия **удалена в 1.0.6**.
