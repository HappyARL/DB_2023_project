# Физическая модель

---

Таблица `client`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `ФИО`         | ФИО клиента      | `VARCHAR(200)`      | `NOT NULL` |
| `Телефон`     | Контакт с клиентом        | `VARCHAR(11)` | `NOT NULL` |
| `Номер_паспорта`       | Верификация клиента      | `INTEGER` | `NOT NULL` `PRIMARY KEY`    |
| `Адрес`       | Адрес проживания    | `VARCHAR(200)`      | `NOT NULL`    |

Таблица `employee`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Id_number`         | Индификатор      | `INTEGER`      | `NOT NULL` `PRIMARY KEY` |
| `ФИО`       | ФИО сотрудника    | `VARCHAR(200)` | `NOT NULL`    |
| `Телефон`     | Контакт с сотрудником        | `VARCHAR(11)` | `NOT NULL`    |
| `Отдел`       | Род деятельности     | `VARCHAR(200)` | `NOT NULL`    |
| `Зарплата`       | Фиксированная зарплата    | `INTEGER`      | `NOT NULL`    |

Таблица `service`


| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Код_услуги`         | Индификатор      | `VARCHAR(200)` | `NOT NULL` `PRIMARY KEY`   |
| `Цена`       | Фиксированная цена    | `DECIMAL(10, 2)`      | `NOT NULL`    |
| `Название`       | Название услуги     | `VARCHAR(200)` | `NOT NULL`    |

Таблица `order`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Заказчик`         | ФИО заказчика      | `VARCHAR(200)`      | `NOT NULL` |
| `Исполнитель`       | Сотрудник которого назначили    | `VARCHAR(200)` | `NOT NULL`    |
| `Дата_заказа`     | Дата регистрации заказа (не начала работы)        | `DATE` | `NOT NULL`    |
| `Цена`       | Цена работы на основе типа услуги    | `DECIMAL(10, 2)`      | `NOT NULL`    |
| `Адрес`       | Адрес где будет выполнена работа     | `VARCHAR(200)` | `NOT NULL`    |
| `Дата_исполнения`       | Дата выполнения работы (полностью)    | `DATE`      | `NOT NULL`    |
| `Код_услуги`       |  Код заказа (Идентификатор)    | `VARCHAR(200)`      | `NOT NULL`    |
| `Номер_Заказа`       | Идентификатор    | `INTEGER` | `NOT NULL`    |

Таблица `internet`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Тариф`         | Название      | `VARCHAR(200)`      | `NOT NULL` |
| `Скорость`       | Скорость интернета (Мбит/с)    | `INTEGER` | `NOT NULL`    |
| `Интернет_провайдер`     | Помимо своего инета мы предоставляем доступ к другим компаниям        | `VARCHAR` | `NOT NULL`    |
| `Цена`       | Цена за тариф    | `DECIMAL(10, 2)`      | `PRIMARY KEY`    |
| `Код_услуги_интернет`       |  Код заказа (Идентификатор)    | `VARCHAR(200)`      | `NOT NULL` `PRIMARY KEY`    |

Таблица `tv`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Тариф`         | Название      | `VARCHAR(200)`      | `NOT NULL` |
| `Количество_каналов`       | Количество телеканалов которые будут доступны клиенту    | `INTEGER` | `NOT NULL`    |
| `Цена`       | Цена за тариф    | `DECIMAL(10, 2)`      | `PRIMARY KEY`    |
| `Код_услуги_телевизор`       |  Код заказа (Идентификатор)    | `VARCHAR(200)`      | `NOT NULL` `PRIMARY KEY`    |

Таблица `phone`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Тариф`         | Название      | `VARCHAR(200)`     | `NOT NULL` |
| `Код_услуги_телефон`       |  Код заказа (Идентификатор)    | `VARCHAR(200)`      | `NOT NULL` `PRIMARY KEY`    |
| `Цена`       | Цена за тариф    | `DECIMAL(10, 2)`      | `PRIMARY KEY`    |

Таблица `incountry`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Код`       |  Код заказа (Идентификатор)    | `VARCHAR(200)`      | `NOT NULL` `PRIMARY KEY`    |
| `Город`       |  Доступные города    | `VARCHAR(200)`     | `NOT NULL`    |
| `Цена`       | Цена которую будет платить клиент чтобы звонить в определенный город не оплачивая поминутно    | `DECIMAL(10, 2)`      | `NOT NULL`    |

Таблица `outcountry`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `Код`       |  Код заказа (Идентификатор)    | `VARCHAR(200)`      | `NOT NULL` `PRIMARY KEY`    |
| `Страна`       |  Доступные страны    | `VARCHAR(200)`      | `NOT NULL`    |
| `Цена`       | Цена которую будет платить клиент чтобы звонить в определенную страну не оплачивая поминутно    | `DECIMAL(10, 2)`      | `NOT NULL`    |

---

Таблица `client`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.client (
    ФИО VARCHAR(200) NOT NULL,
    Телефон VARCHAR(11) NOT NULL,
    Номер_паспорта INTEGER NOT NULL UNIQUE,
    Адрес VARCHAR(200) NOT NULL
);
```

Таблица `employee`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.employee (
	id_number INTEGER NOT NULL PRIMARY KEY,
	ФИО VARCHAR(200) NOT NULL,
	Телефон VARCHAR(11) NOT NULL,
	Отдел VARCHAR(200) NOT NULL,
	Зарплата INTEGER NOT NULL
);
```

Таблица `services`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.services (
    Код_услуги VARCHAR(200) NOT NULL PRIMARY KEY,
    Цена DECIMAL(10, 2) NOT NULL,
    Название VARCHAR(200) NOT NULL
);
```

Таблица `order`:
```postgresql
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
```

Таблица `internet`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.internet (
	Тариф VARCHAR(200) NOT NULL,
	Скорость INTEGER NOT NULL,
	Интернет_провайдер VARCHAR(200) NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Код_услуги_интернет VARCHAR(200) NOT NULL PRIMARY KEY
);
```

Таблица `tv`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.tv (
	Тариф VARCHAR(200) NOT NULL,
	Количество_каналов INTEGER NOT NULL,
	Цена DECIMAL(10, 2) NOT NULL,
	Код_услуги_телевизор VARCHAR(200) NOT NULL PRIMARY KEY
);
```

Таблица `phone`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.phone (
	Тариф VARCHAR(200) NOT NULL,
	Код_услуги_телефон VARCHAR(200) NOT NULL PRIMARY KEY,
	Цена DECIMAL(10, 2) NOT NULL
);
```

Таблица `incountry`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.incountry (
    	Код VARCHAR(200) NOT NULL PRIMARY KEY,
	Город VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL
);
```

Таблица `outcountry`:
```postgresql
CREATE TABLE IF NOT EXISTS cmp.outcountry (
    	Код VARCHAR(200) NOT NULL PRIMARY KEY,
	Страна VARCHAR(200) NOT NULL,
	Цена INTEGER NOT NULL
);
```
