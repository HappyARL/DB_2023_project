-- Создание схемы

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

CREATE TABLE IF NOT EXISTS cmp.services (
    Код_услуги VARCHAR(200) NOT NULL PRIMARY KEY,
    Цена DECIMAL(10, 2) NOT NULL,
    Название VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.order (
    Заказчик INTEGER NOT NULL,
    Исполнитель INTEGER NOT NULL,
    Дата_заказа DATE NOT NULL,
    Цена DECIMAL(10, 2) NOT NULL,
    Адрес VARCHAR(200) NOT NULL,
    Дата_исполнения DATE NOT NULL,
    Код_услуги VARCHAR(200) NOT NULL,
    Номер_заказа INTEGER NOT NULL,

    PRIMARY KEY (Заказчик, Исполнитель, Адрес, Код_услуги),
    FOREIGN KEY (Заказчик) REFERENCES cmp.client(Номер_паспорта),
    FOREIGN KEY (Исполнитель) REFERENCES cmp.employee (id_number),
    FOREIGN KEY (Адрес) REFERENCES cmp.client (Адрес),
    FOREIGN KEY (Код_услуги) REFERENCES cmp.services (Код_услуги)
);

CREATE TABLE IF NOT EXISTS cmp.internet (
	Тариф VARCHAR(200) NOT NULL,
	Скорость INTEGER NOT NULL,
	Интернет_провайдер VARCHAR(200) NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Код_услуги_интернет VARCHAR(200) NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS cmp.tv (
	Тариф VARCHAR(200) NOT NULL,
	Количество_каналов INTEGER NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Код_услуги_телевизор VARCHAR(200) NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS cmp.phone (
	Тариф VARCHAR(200) NOT NULL,
	Код_услуги_телефон VARCHAR(200) NOT NULL PRIMARY KEY,
	Цена DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.incountry (
    Код VARCHAR(200) NOT NULL PRIMARY KEY,
	Город VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS cmp.outcountry (
    Код VARCHAR(200) NOT NULL PRIMARY KEY,
	Страна VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL
);
