Выполнить конвертацию необходимо разово, чтобы "переключить" текущий формат с 1С:Предприятия на формат 1C:EDT.

![Конвертация хранилища в формат 1C:EDT - Convert repository to 1C:EDT](../blob/master/ConvertToEDT.png?raw=true)

__Внимание!__ 
Конвертация в формат 1C:EDT необратима, поэтому последующая синхронизация с хранилищем 1С будет выполняться в формате 1C:EDT. Конечно, можно сделать "checkout" на коммит до конвертации и продолжить конвертацию в формате 1С:Предприятия в другой ветке, или откатить все изменения с помощью `git reset --hard <sha_commit>` и т.д. 
Можно так же, в тестовых целях, создать копию элемента справочника "Хранилищ" и копию репозитория - создать ветку и конвертировать в формат 1C:EDT, оставляя возможность синхронизировать хранилище конфигураций с основной веткой Git в формате 1С:Предприятия.

Структура каталогов выгрузки 1С:Предприятия и формата 1C:EDT похожи, но немного различаются. Для сохранения истории разработки в формате 1C:EDT запустите обработку __"Конвертация в формат EDT"__. Она выполняет перемещение файлов в соответствии с форматом 1C:EDT, выполняет коммит в гит, заменяет каталог `src` выгрузки 1С:Предприятия каталогом из 1C:EDT и выполняет второй коммит с изменением контента файлов.
Стоит отметить, что содержание xml-файлов 1C:EDT и 1С:Предприятия в некоторых случаях различается существенно, поэтому построчное авторство в таких файлах сохранить не удастся. 
Файлы текстов модулей `*.bsl` сохраняют историю полностью.

1. Установите 1C:EDT 1.8 и выше на сервер.
2. Если изначально каталог с именем проекта не был указан (ну забыли, не знали...) нужно заполнить **Имя проекта 1C:EDT** и будет выполнено перемещение `git mv ./src/... ./ИмяПроектаEDT/src/...` во время конвертации. Перемещение можно отключить, сняв галку **Выполнить перенос в каталог проекта**, если вы понимаете зачем это делаете.
3. Если использовали __Git LFS__ - убедитесь что типы файлов, вынесенные в __LFS__, после конвертации с новыми именами/расширениями так же попадут в __LFS__.
4. Выполните конвертацию репозитория с помощью обработки __Сервис -> Конвертация в формат EDT__, заполнив все обязательные поля.

Если изначально был указан __"Каталог выгрузки в репозитории"__ соответствующий имени проекта, после конвертации можно открыть 1C:EDT в новом  Workspace и выполнить импорт проекта из Git: __File -> Import -> Git -> Projects from Git__ и убедиться в корректности конвертации.

__Внимание!__ Рекомендуется читать документацию к 1C:EDT о настройках Git, работе с проектом, импорте и др.

Соответствие имен файлов формата выгрузки 1С:Предприятия и формата 1C:EDT

```
Configuration.xml -> Configuration.mdo
ClientApplicationInterface.xml -> ClientApplicationInterface.cai
CommandInterface.xml -> CommandInterface.cmi
HomePageWorkArea.xml -> HomePageWorkArea.hpwa
MainSectionCommandInterface.xml -> MainSectionCommandInterface.cmi
Form.xml -> Form.form
Template.xml -> Template.bin     // BinaryData
Template.xml -> Template.mxlx    // SpreadsheetDocument
Template.xml -> Template.dcs     // DataCompositionSchema
Template.xml -> Template.txt     // FileAwareTextDocument
Template.xml -> Template.htmldoc // HtmlDocument
Template.xml -> Template.addin   // AddIn
Template.xml -> Template.scheme  // GraphicalScheme
Template.xml -> Template.axdt    // ActiveDocument
Template.xml -> Template.geos    // GeographicalSchema
Template.xml -> Template.dcsat   // DataCompositionAppearanceTemplate
Package.bin -> Package.xdto
WSDefinition.xml -> WsDefinitions.wsdl
Flowchart.xml -> Flowchart.scheme
Rights.xml -> Rights.rights
Schedule.xml -> Schedule.schedule
```

Другие файлы изменят имена не значительно, в соответствии с форматом 1C:EDT. Часть файлов (`Help.xml`, `Language.xml`, `Picture.xml`, `ФормаСписка.xml` и др.) будут удалены, т.к. контент файлов теперь хранится в составе других файлов.
