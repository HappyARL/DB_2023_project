CREATE SCHEMA IF NOT EXISTS cmp;

-- Создание таблиц

CREATE TABLE IF NOT EXISTS cmp.client (
    ФИО VARCHAR(200) NOT NULL,
    Телефон VARCHAR(11) NOT NULL,
    Номер_паспорта INTEGER NOT NULL UNIQUE,
    Адрес VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.employee (
	id_number INTEGER NOT NULL PRIMARY KEY,
	ФИО VARCHAR(200) NOT NULL,
	Телефон VARCHAR(11) NOT NULL,
	Отдел VARCHAR(200) NOT NULL,
	Зарплата INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.order (
	Заказчик INTEGER NOT NULL,
	Исполнитель INTEGER NOT NULL,
	Дата_заказа DATE NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Адрес VARCHAR(200) NOT NULL,
	Дата_исполнения DATE NOT NULL,
	Код_услуги INTEGER NOT NULL,
	Номер_заказа INTEGER NOT NULL,

	PRIMARY KEY (Заказчик, Исполнитель, Адрес, Код_услуги),
	FOREIGN KEY (Заказчик) REFERENCES cmp.client(Номер_паспорта),
	FOREIGN KEY (Исполнитель) REFERENCES cmp.employee (id_number),
	FOREIGN KEY (Адрес) REFERENCES cmp.client (Адрес),
	FOREIGN KEY (Код_услуги) REFERENCES cmp.internet (Код_услуги_интернет)
	--FOREIGN KEY (Код_услуги) REFERENCES cmp.tv (Код_услуги_телевизор),
	--FOREIGN KEY (Код_услуги) REFERENCES cmp.phone (Код_услуги_телефон)
);


CREATE TABLE IF NOT EXISTS cmp.internet (
	Тариф VARCHAR(200) NOT NULL,
	Скорость INTEGER NOT NULL,
	Интернет_провайдер VARCHAR(200) NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Код_услуги_интернет INTEGER NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS cmp.tv (
	Тариф VARCHAR(200) NOT NULL,
	Количество_каналов INTEGER NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Код_услуги_телевизор INTEGER NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS cmp.phone (
	Код_услуги_телефон INTEGER NOT NULL PRIMARY KEY,
	Цена DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.incountry (
	Город VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.outcountry (
	Страна VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL
);

-- Связывание таблиц и преобразование 
SELECT CONCAT_WS('_', ic.Город, oc.Страны) AS Выбор_клиента,
       p.Код_услуги_телефон
FROM cmp.phone p
JOIN cmp.incountry ic ON p.Меж_город = ic.Город
JOIN cmp.outcountry oc ON p.Меж_страны = oc.Страны;

-- Обратное преобразование кода в выбор клиента
SELECT CONCAT_WS(', ', SUBSTRING(p.Код_услуги_телефон, 1, CHARINDEX('_', p.Код_услуги_телефон)-1),
                         ic.Город,
                         SUBSTRING(p.Код_услуги_телефон, CHARINDEX('_', p.Код_услуги_телефон)+1)) AS Выбор_клиента
FROM cmp.phone p
JOIN cmp.incountry ic ON p.Меж_город = ic.Город
JOIN cmp.outcountry oc ON p.Меж_страны = oc.Страны;
