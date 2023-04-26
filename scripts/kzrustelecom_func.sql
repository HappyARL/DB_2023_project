-- Создание процелуры и функции

-- Процедура
CREATE PROCEDURE add_client(
    IN ФИО_ VARCHAR(200),
    IN Телефон_ VARCHAR(11),
    IN Номер_паспорта_ INTEGER,
    IN Адрес_ VARCHAR(200)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO cmp.client ("ФИО", "Телефон", "Номер_паспорта", "Адрес")
    VALUES (ФИО_, Телефон_, Номер_паспорта_, Адрес_);
END;$$ ;

CALL add_client('Алиев Арлан Сеитович', '77777777777', 100000, 'ул. Алиева, д.69');

-- Функция
CREATE FUNCTION client_spends(passport INTEGER)
RETURNS NUMERIC(10, 2)
LANGUAGE plpgsql
AS $$
DECLARE
    total_sum NUMERIC(10, 2);
BEGIN
    SELECT SUM(o."Цена") INTO total_sum
    FROM cmp."order" o
    WHERE o.Заказчик = passport;

    RETURN COALESCE(total_sum, 0);
END; $$;

SELECT client_spends(990011);

-- Тригеры

-- Создание тригеров
CREATE FUNCTION check_employee_availability()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    available_employee INTEGER;
BEGIN
    SELECT COUNT(*) INTO available_employee
    FROM cmp."order" o
    INNER JOIN cmp.employee e ON e.id_number = o."Исполнитель"
    WHERE e.id_number = NEW."Исполнитель";

    IF available_employee > 0 THEN
        RAISE EXCEPTION 'Нет свободных сотрудников';
    END IF;
    RETURN NEW;
END; $$;

CREATE TRIGGER check_employee_availability_trigger
BEFORE INSERT ON cmp.order
FOR EACH ROW
EXECUTE PROCEDURE check_employee_availability();

INSERT INTO cmp.order
("Заказчик", "Исполнитель", "Дата_заказа", "Цена", "Адрес", "Дата_исполнения", "Код_услуги", "Номер_заказа") VALUES
(100000, 5, '2021-12-23', 100.0, 'ул. Алиева, д.69', '2021-12-24', '1072039310', 11);

INSERT INTO cmp.order
("Заказчик", "Исполнитель", "Дата_заказа", "Цена", "Адрес", "Дата_исполнения", "Код_услуги", "Номер_заказа") VALUES
(100000, 8, '2021-12-23', 100.0, 'ул. Алиева, д.69', '2021-12-24', '1072039310', 11);

---
CREATE FUNCTION check_client_info()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF LENGTH(NEW."Телефон") <> 11 OR LENGTH(CAST(NEW."Номер_паспорта" AS VARCHAR)) <> 6 THEN
        RAISE EXCEPTION 'Не верный номер телефона или паспорта';
    END IF;
    RETURN NEW;
END; $$;

CREATE TRIGGER check_check_client_info_trigger
BEFORE INSERT ON cmp.client
FOR EACH ROW
EXECUTE PROCEDURE check_client_info();

INSERT INTO cmp.client ("ФИО", "Телефон", "Номер_паспорта", "Адрес") VALUES
('ABC', 12345678901, 696969, 'st. abc');

INSERT INTO cmp.client ("ФИО", "Телефон", "Номер_паспорта", "Адрес") VALUES
('ABC', 123, 69, 'st. abc');
