
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
		
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);

КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры


	 
&НаКлиенте
Процедура Дораб_ПересчитатьТаблицу(Команда)
	
	//Пересчет по кнопке "ПересчитатьТаблицу"	
	Дораб_ПересчетСуммыТабличныхЧастей();
	
КонецПроцедуры

 &НаКлиенте
 Процедура Дораб_ПересчетСуммыТабличныхЧастей()
	 
	 //Процедура для пересчета Суммы с учетом скидки при обходе табличных частей Товары и Услуги
	 Для Каждого СтрокаТовары Из Объект.Товары Цикл		
		 РассчитатьСуммуСтроки(СтрокаТовары);		
	 КонецЦикла;
	 
	 Для Каждого СтрокаУслуги Из Объект.Услуги Цикл		
		 РассчитатьСуммуСтроки(СтрокаУслуги);		
	 КонецЦикла;
	 
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	//Процедура для пересчета Суммы с учетом реквизита Согласованная скидка и поля скидки табличной части
	КоэффициентСкидки = 1 - (ТекущиеДанные.Скидка + Объект.Дораб_СогласованнаяСкидка) / 100;
	
	Если КоэффициентСкидки < 0 Тогда
		ТекущиеДанные.Сумма = 0;
		ПоказатьПредупреждение(, "Суммарная скидка не может быть больше 100%!");
	Иначе
		ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура Дораб_СогласованнаяСкидкаПриИзменении(Элемент)
	
	//Процедура вывода Оповещения пользователю    		
	Оповещение = Новый ОписаниеОповещения("Дораб_ПослеЗакрытияВопроса", ЭтотОбъект);		
	ПоказатьВопрос(Оповещение, "Применить скидку в документе?", РежимДиалогаВопрос.ДаНет); 	
	
КонецПроцедуры


&НаКлиенте
Процедура Дораб_ПослеЗакрытияВопроса(Результат, ДополнительныеПараметры) Экспорт

	//Пересчет по полю Согласованная скидка	
	Если Результат = Неопределено Или Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	Дораб_ПересчетСуммыТабличныхЧастей()    	
		
КонецПроцедуры


#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
