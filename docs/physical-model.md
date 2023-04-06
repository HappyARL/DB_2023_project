# Физическая модель

---

Таблица `client`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `ФИО`         | ФИО клиента      | `VARCHAR(200)`      | `NOT NULL` |
| `Номер_Заказа`       | Идентификатор    | `INTEGER` | `NOT NULL`    |
| `Телефон`     | Контакт с клиентом        | `VARCHAR(11)` | `NOT NULL` |
| `Номер_паспорта`       | Верификация клиента      | `INTEGER` | `PRIMARY KEY`    |
| `Адрес`       | Адрес проживания    | `VARCHAR(200)`      | `NOT NULL`    |

Таблица `employee`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Id_number`         | Индификатор      | `INTEGER`      | `PRIMARY KEY` |
| `ФИО`       | ФИО сотрудника    | `VARCHAR(200)` | `NOT NULL`    |
| `Телефон`     | Контакт с сотрудником        | `VARCHAR(11)` | `NOT NULL`    |
| `Отдел`       | Род деятельности     | `VARCHAR(200)` | `NOT NULL`    |
| `Зарплата`       | Фиксированная зарплата    | `INTEGER`      | `NOT NULL`    |

Таблица `order`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Заказчик`         | ФИО заказчика      | `VARCHAR`      | `NOT NULL` |
| `Исполнитель`       | Сотрудник которого назначили    | `VARCHAR(200)` | `NOT NULL`    |
| `Дата_заказа`     | Дата регистрации заказа (не начала работы)        | `DATE` | `NOT NULL`    |
| `Цена`       | Цена работы на основе типа услуги    | `INTEGER`      | `PRIMARY KEY`    |
| `Адрес`       | Адрес где будет выполнена работа     | `VARCHAR(200)` | `NOT NULL`    |
| `Дата_исполнения`       | Дата выполнения работы (полностью)    | `DATE`      | `NOT NULL`    |
| `Код_услуги`       |  Код заказа (Идентификатор)    | `INTEGER`      | `PRIMARY KEY`    |
| `Номер_Заказа`       | Идентификатор    | `INTEGER` | `NOT NULL`    |

Таблица `internet`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Тариф`         | Название      | `VARCHAR`      | `NOT NULL` |
| `Скорость`       | Скорость интернета (Мбит/с)    | `INTEGER` | `PRIMARY KEY`    |
| `Интернет_провайдер`     | Помимо своего инета мы предоставляем доступ к другим компаниям        | `VARCHAR` | `NOT NULL`    |
| `Цена`       | Цена за тариф    | `INTEGER`      | `PRIMARY KEY`    |
| `Код_услуги_интернет`       |  Код заказа (Идентификатор)    | `INTEGER`      | `PRIMARY KEY`    |

Таблица `tv`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Тариф`         | Название      | `VARCHAR`      | `NOT NULL` |
| `Количество_каналов`       | Количество телеканалов которые будут доступны клиенту    | `INTEGER` | `PRIMARY KEY`    |
| `Цена`       | Цена за тариф    | `INTEGER`      | `PRIMARY KEY`    |
| `Код_услуги_телевизор`       |  Код заказа (Идентификатор)    | `INTEGER`      | `PRIMARY KEY`    |

Таблица `phone`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Тариф`         | Название      | `VARCHAR`      | `NOT NULL` |
| `Меж_город`       | Цена звонков в другие города, РФ чтобы не платить поминутно (по дефолту рубли/мин)    | `VARCHAR` | `NOT NULL`    |
| `Меж_страны`     | Цена звонков в другие страны, чтобы не платить поминутно (по дефолту рубли/мин)        | `VARCHAR` | `NOT NULL`    |
| `Цена`       | Цена за тариф    | `INTEGER`      | `PRIMARY KEY`    |
| `Код_услуги_телефон`       |  Код заказа (Идентификатор)    | `INTEGER`      | `PRIMARY KEY`    |

Таблица `incountry`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Цена`       | Цена которую будет платить клиент чтобы звонить в определенный город не оплачивая поминутно    | `INTEGER`      | `PRIMARY KEY`    |
| `Город`       |  Доступные города    | `VARCHAR`      | `NOT NULL`    |

Таблица `outcountry`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Цена`       | Цена которую будет платить клиент чтобы звонить в определенную страну не оплачивая поминутно    | `INTEGER`      | `PRIMARY KEY`    |
| `Страны`       |  Доступные страны    | `VARCHAR`      | `NOT NULL`    |

---

Таблица `client`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.client (
  	ФИО VARCHAR(200) NOT NULL,
  	Номер_заказа INTEGER NOT NULL,
  	Телефон VARCHAR(11) NOT NULL,
  	Номер_паспорта INTEGER NOT NULL PRIMARY KEY,
  	Адрес VARCHAR(200) NOT NULL,

  	CONSTRAINT unique_passport_number UNIQUE (Номер_паспорта)
);
```

Таблица `employee`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.employee (
	id_number INTEGER NOT NULL PRIMARY KEY,
	ФИО VARCHAR(200) NOT NULL,
	Телефон VARCHAR(11) NOT NULL,
	Отдел VARCHAR(200) NOT NULL,
	Зарплата INTEGER NOT NULL,

	CONSTRAINT unique_id_number UNIQUE (id_number)
);
```

Таблица `order`:
```postgresql
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
```

Таблица `internet`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.internet (
	Тариф VARCHAR(200) NOT NULL,
	Скорость INTEGER NOT NULL,
	Интернет_провайдер VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL,
	Код_услуги_интернет INTEGER NOT NULL PRIMARY KEY,
	
	CONSTRAINT код_инет UNIQUE (Код_услуги_интернет)
);
```

Таблица `tv`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.tv (
	Тариф VARCHAR(200) NOT NULL,
	Количество_каналов INTEGER NOT NULL,
	Цена INTEGER NOT NULL,
	Код_услуги_телевизор INTEGER NOT NULL PRIMARY KEY,
	
	CONSTRAINT код_телевизор UNIQUE (Код_услуги_телевизор)
);
```

Таблица `phone`:
```postgresql
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
```

Таблица `incountry`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.incountry (
	Цена INTEGER NOT NULL,
	Город VARCHAR(200) NOT NULL,
	
	CONSTRAINT платные_города UNIQUE (Город)
);
```

Таблица `outcountry`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.outcountry (
	Цена INTEGER NOT NULL,
	Страны VARCHAR(200) NOT NULL,
	
	CONSTRAINT платная_страна UNIQUE (Страны)
);
```
