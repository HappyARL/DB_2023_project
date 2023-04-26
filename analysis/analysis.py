import psycopg2
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

conn = psycopg2.connect(database="postgres",
                        user="arlan",
                        password="arlan123",
                        host="localhost",
                        port="5432")

cur = conn.cursor()

# Загрузка данных из БД
data = pd.read_sql_query("SELECT * FROM cmp.order ", conn)

# Вывод первых 5 строк таблицы
print(data.head())

# Описание данных
print(data.describe())

# Количество уникальных значений в столбце
print(data['Адрес'].nunique())

# Группировка данных и подсчет количества
grouped_data = data.groupby('Адрес').size().reset_index(name='counts')
print(grouped_data)

# Ящик с усами
sns.boxplot(x='Адрес', y='Цена', data=data)

# Круговая диаграмма
grouped_data.plot(kind='pie', y='counts', labels=grouped_data['Адрес'], autopct='%1.1f%%')

# Линейный график
data.plot(x="Дата_исполнения", y=["Цена", "Код_услуги"])
plt.show()
