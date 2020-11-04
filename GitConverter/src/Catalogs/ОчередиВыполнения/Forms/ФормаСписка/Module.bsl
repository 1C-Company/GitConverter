///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017-2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by-sa/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Список.Параметры.УстановитьЗначениеПараметра("Хранилище", Параметры.Хранилище);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыСписок

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)

    Для Каждого Строка Из Строки Цикл
        Задание = РегламентныеЗадания.НайтиПоУникальномуИдентификатору(Строка.Значение.Данные.РегламентноеЗадание);	
        Если Задание <> Неопределено Тогда
            Строка.Значение.Данные.Используется = Задание.Использование;
        КонецЕсли; 
    КонецЦикла; 

КонецПроцедуры

#КонецОбласти