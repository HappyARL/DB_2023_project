-- Представления

-- Создание таблицы "representative"
CREATE TABLE IF NOT EXISTS cmp.representative (
 id_rep INTEGER NOT NULL PRIMARY KEY,
 ФИО VARCHAR(200) NOT NULL,
 Телефон VARCHAR(11) NOT NULL,
 Должность VARCHAR(200) NOT NULL
);

-- Добавление поля "ID представителя" в таблицы "client", "employee" и "order"
ALTER TABLE cmp.client ADD COLUMN id_rep INTEGER REFERENCES cmp.representative(id_rep);
ALTER TABLE cmp.employee ADD COLUMN id_rep INTEGER REFERENCES cmp.representative(id_rep);
ALTER TABLE cmp."order" ADD COLUMN id_rep INTEGER REFERENCES cmp.representative(id_rep);

-- Ваод данных
INSERT INTO cmp.representative (id_rep, "ФИО", "Телефон", "Должность")  VALUES
(4, 'Лутфулаев Сардор Пловович', '34567890123', 'Отдел маркетинга'),
(5, 'Ткачик Андрей Донбасович','34567890123', 'IT сектор'),
(6, 'Косенко Иван Картошкович', '34567890123', 'IT сектор');

-- Представление 1: список представителей компании с их контактными данными и должностями
CREATE VIEW cmp.view_representatives AS
SELECT id_rep, repr.ФИО, repr.Телефон, repr.Должность FROM cmp.representative repr;

-- Представление 2: список клиентов компании с их контактными данными и ID представителя
CREATE VIEW cmp.view_clients AS
SELECT client.ФИО, client.Телефон, client.Адрес, id_rep FROM cmp.client client;

-- Представление 3: сводная таблица с информацией о заказах клиентов, включая ФИО клиента, ID представителя и дату заказа
CREATE VIEW cmp.view_orders AS
SELECT c.ФИО AS Клиент, o.id_rep AS Представитель, o.Дата_заказа AS Дата_заказа, o.Адрес AS Адрес_заказа
FROM cmp."order" o
JOIN cmp.client c ON o.Заказчик = c.Номер_паспорта;

-- Представление 4: список сотрудников компании с их информацией
CREATE VIEW cmp.view_employees AS
SELECT e.id_number, e.ФИО, e.Телефон, e.Отдел, e.Зарплата, r.id_rep AS Представитель
FROM cmp.employee e
JOIN cmp.representative r ON e.id_number = r.id_rep;

-- Представление 5: сводная таблица с информацией о заказах клиентов и услугах (по критерию)
CREATE VIEW cmp.view_order_services AS
SELECT o.Номер_заказа, c.ФИО AS Клиент, o."Код_услуги" AS Услуга, o.Цена AS Цена_заказа
FROM cmp."order" o
JOIN cmp.client c ON o.Заказчик = c.Номер_паспорта
WHERE SUBSTR(o."Код_услуги", 1, 3) = '100';

-- Представление 6: список клиентов компании с их контактными данными и номером заказа, который они сделали
CREATE VIEW cmp.view_client_orders AS
SELECT c.ФИО, c.Телефон, o.Номер_заказа
FROM cmp."order" o
JOIN cmp.client c ON o.Заказчик = c.Номер_паспорта;
