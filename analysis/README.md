# Анализ заказов

---

`order_generator.py` - генерирует заказы на основе данных, которые хранятся в таблицах cmp.client / cmp.employee / cmp.services.

`analysis.py` - рисует графики на основе таблицы cmp.prder.

Использовались библиотеки **psycopg2**, **matplotlib**, **pandas**, **seaborn**.

Соединение с БД осуществлялось слудующим образом:

```python
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
```

---

## ГРАФИКИ:

### Линейный график
Прибыль компании за 2023 год в виде графа по датам:

![Линейный график](/analysis/1.png)

### Круговая диаграмма
Процентное соотношение улиц:

![Круговая диаграмма](/analysis/2.png)

### Диаграмма размаха
Средняя / Макс / Мин цена заказа по каждой улице:

![Диаграмма размаха](/analysis/3.png)

---
