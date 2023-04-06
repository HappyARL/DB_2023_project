CREATE SCHEMA IF NOT EXISTS cmp;

CREATE TABLE IF NOT EXISTS cmp.client (
  	ФИО VARCHAR(200) NOT NULL,
  	Номер_заказа INTEGER NOT NULL,
  	Телефон VARCHAR(11) NOT NULL,
  	Номер_паспорта INTEGER NOT NULL PRIMARY KEY,
  	Адрес VARCHAR(200) NOT NULL,

  	CONSTRAINT unique_passport_number UNIQUE (Номер_паспорта)
);

CREATE TABLE IF NOT EXISTS cmp.employee (
	id_number INTEGER NOT NULL PRIMARY KEY,
	ФИО VARCHAR(200) NOT NULL,
	Телефон VARCHAR(11) NOT NULL,
	Отдел VARCHAR(200) NOT NULL,
	Зарплата INTEGER NOT NULL,

	CONSTRAINT unique_id_number UNIQUE (id_number)
);

CREATE TABLE IF NOT EXISTS cmp.order (
	Заказчик VARCHAR(200) NOT NULL,
	Исполнитель INTEGER NOT NULL,
	Дата_заказа DATE NOT NULL,
	Цена INTEGER NOT NULL,
	Адрес VARCHAR(200) NOT NULL,
	Дата_исполнения DATE NOT NULL,
	Код_услуги INTEGER NOT NULL,
	Номер_заказа INTEGER NOT NULL PRIMARY KEY

	CONSTRAINT клиент_заказчик FOREIGN KEY (Заказчик) REFERENCES cmp.client(Номер_паспорта),
	CONSTRAINT сотрудник_исполнитель FOREIGN KEY (Исполнитель) REFERENCES cmp.employee(id_number),
	CONSTRAINT адрес_заказчика FOREIGN KEY (Адрес) REFERENCES cmp.client(Номер_паспорта),
	CONSTRAINT id_заказа FOREIGN KEY (Номер_заказа) REFERENCES cmp.client(Номер_заказа),
	--код услуги
);

-- функция которая принимает коды услуг и создает общий код для всех

CREATE TABLE IF NOT EXISTS cmp.internet (
	Тариф VARCHAR(200) NOT NULL,
	Скорость INTEGER NOT NULL,
	Интернет_провайдер VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL,
	Код_услуги_интернет INTEGER NOT NULL PRIMARY KEY,
	
	CONSTRAINT код_инет UNIQUE (Код_услуги_интернет)
);

CREATE TABLE IF NOT EXISTS cmp.tv (
	Тариф VARCHAR(200) NOT NULL,
	Количество_каналов INTEGER NOT NULL,
	Цена INTEGER NOT NULL,
	Код_услуги_телевизор INTEGER NOT NULL PRIMARY KEY,
	
	CONSTRAINT код_телевизор UNIQUE (Код_услуги_телевизор)
);

CREATE TABLE IF NOT EXISTS cmp.phone (
	Тариф VARCHAR(200) NOT NULL,
	Меж_город VARCHAR(200) NOT NULL,
	Меж_страны VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL,
	Код_услуги_телефон INTEGER NOT NULL PRIMARY KEY,
	
	CONSTRAINT код_телефон UNIQUE (Код_услуги_телефон),
	CONSTRAINT платный_город FOREIGN KEY (Меж_город) REFERENCES cmp.incountry(Город),
	CONSTRAINT платная_страна FOREIGN KEY (Меж_страны) REFERENCES cmp.outcountry(Страны)
);

CREATE TABLE IF NOT EXISTS cmp.incountry (
	Цена INTEGER NOT NULL,
	Город VARCHAR(200) NOT NULL,
	
	CONSTRAINT платные_города UNIQUE (Город)
);

CREATE TABLE IF NOT EXISTS cmp.outcountry (
	Цена INTEGER NOT NULL,
	Страны VARCHAR(200) NOT NULL,
	
	CONSTRAINT платная_страна UNIQUE (Страны)
);

