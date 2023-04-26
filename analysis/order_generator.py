import psycopg2
import pandas as pd
import random

conn = psycopg2.connect(database="postgres",
                        user="arlan",
                        password="arlan123",
                        host="localhost",
                        port="5432")

cur = conn.cursor()


def generate_order_info():
    # Получение случайного заказчика из таблицы client
    customers = pd.read_sql_query("SELECT * FROM cmp.client", conn)
    customer = customers.sample().iloc[0]

    # Получение случайного исполнителя из таблицы employee
    employees = pd.read_sql_query("SELECT * FROM cmp.employee", conn)
    employee = employees.sample().iloc[0]

    # Получение случайной услуги из таблицы services
    services = pd.read_sql_query("SELECT * FROM cmp.services", conn)
    service = services.sample().iloc[0]

    # Генерация случайной даты заказа и исполнения
    order_date = pd.Timestamp(year=2023, month=1, day=1).date()
    execution_date = order_date + pd.Timedelta(days=random.randint(1, 30))

    # Генерация случайного номера заказа
    order_number = random.randint(1, 200)

    # Формирование словаря с информацией о заказе
    customer_passport = customer['Номер_паспорта']
    employee_id = employee['id_number']
    order_date = order_date
    service_price = service['Цена']
    customer_address = customer['Адрес']
    execution_date = execution_date
    service_code = service['Код_услуги']
    order_number = order_number
    cur.execute(f"INSERT INTO cmp.\"order\" (\"Заказчик\", \"Исполнитель\", \"Дата_заказа\", \"Цена\", \"Адрес\","
                f"\"Дата_исполнения\", \"Код_услуги\", \"Номер_заказа\") VALUES "
                f"('{customer_passport}', '{employee_id}', '{order_date}', {service_price}, '{customer_address}',"
                f"'{execution_date}', '{service_code}', {order_number}) "
    )


# Генерация информации о заказе
for i in range(100):
    generate_order_info()

conn.commit()

cur.execute("SELECT * FROM cmp.order")

rows = cur.fetchall()
for row in rows:
    print(row)

# Закрытие соединения с базой данных
cur.close()
conn.close()
