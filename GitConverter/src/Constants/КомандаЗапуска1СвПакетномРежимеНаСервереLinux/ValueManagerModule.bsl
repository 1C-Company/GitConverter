#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если НЕ ПустаяСтрока(ЭтотОбъект.Значение) И СтрНайти(ЭтотОбъект.Значение, "%СтрокаКоманды%") = 0  Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'В описании команды запуска необходимо использовать <%СтрокаКоманды%>.'"),
			,
			"КомандаЗапуска1СвПакетномРежимеНаСервереLinux",
			"НаборКонстант", 
			Отказ);
	КонецЕсли; 
 
КонецПроцедуры

#КонецОбласти

#КонецЕсли
