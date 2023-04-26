-- CRUD-запросы

-- CREATE:
INSERT INTO cmp.employee ("id_number", "ФИО", "Телефон", "Отдел", "Зарплата") VALUES
(11, 'Леннон Джон Уинстон', '34767890123', 'Тех-поддрежка', 50000);
INSERT INTO cmp.outcountry ("Код", "Страна", "Цена") VALUES
('11', 'Кения',1000.0);

-- READ:
SELECT * FROM cmp.client;
SELECT
    client.ФИО,
    client.Номер_паспорта,
    client.Адрес
FROM cmp.client client
WHERE client.Адрес = 'ул. Ленина, д.1';

-- UPDATE:
UPDATE cmp.client SET Телефон = '12223334455' WHERE Телефон = '72341236745';
UPDATE cmp.employee SET Зарплата = 80000 WHERE id_number = 2;
UPDATE cmp.employee SET Зарплата = 90000 WHERE id_number = 5;

-- DELETE:
DELETE FROM cmp.client WHERE Номер_паспорта = 112233;
DELETE FROM cmp.employee WHERE Зарплата < 60000;
DELETE FROM cmp."order" WHERE EXTRACT(YEAR FROM Дата_исполнения) = 2020;

-- Осмысленные запросы

SELECT * FROM cmp.employee emp
ORDER BY emp.Зарплата DESC;

SELECT
	client.ФИО,
	client.Адрес
FROM cmp.client client
WHERE SUBSTRING(client.Адрес, 1, 10) = 'ул. Ленина';

SELECT
	ROW_NUMBER() OVER (PARTITION BY emp.Отдел ORDER BY emp.Зарплата DESC) AS Рейтинг,
	emp.ФИО,
	emp.Отдел,
	emp.Зарплата
FROM cmp.employee emp;

SELECT
	ord.Номер_заказа,
	ord.Цена
FROM cmp."order" ord
WHERE ord.Цена > 2000.0
ORDER BY ord.Дата_заказа DESC;


SELECT
	ord.Заказчик,
	ord.Исполнитель
FROM cmp."order" ord
WHERE EXTRACT(YEAR FROM ord.Дата_исполнения) = 2021;

SELECT
	id_number,
	emp.ФИО
FROM cmp.employee emp
WHERE emp.Отдел = 'IT сектор';
