-- Создание индексов
CREATE INDEX "pasport_num"
  ON cmp.client(Номер_паспорта);

CREATE INDEX "department"
  ON cmp.employee(Отдел);

CREATE INDEX "order_client"
  ON cmp."order"(Номер_заказа);

CREATE INDEX "order_employee"
  ON cmp."order"(Исполнитель);
