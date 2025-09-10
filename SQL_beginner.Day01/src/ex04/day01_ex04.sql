SELECT person_id FROM person_order
    WHERE (order_date='2022-01-07')
EXCEPT ALL 
-- EXCEPT возвращает уникальные строки из левого входного запроса, которые не выводятся правым входным запросом.
SELECT person_id FROM person_visits
    WHERE (visit_date='2022-01-07')