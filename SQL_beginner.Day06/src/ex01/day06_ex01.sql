INSERT INTO person_discounts (id, person_id, pizzeria_id, discount)
SELECT
    ROW_NUMBER() OVER () AS id,
    person_id, 
    pizzeria_id,
    case when orders_cnt = 1 then 10.5
         when orders_cnt = 2 then 22
         else 30
    end discount
FROM (
        SELECT
             po.person_id,
             m.pizzeria_id,
             count(po.person_id) as orders_cnt
         FROM person_order po
         JOIN menu m
            ON po.menu_id = m.id
         GROUP BY person_id, pizzeria_id
     );

-- SELECT * FROM person_discounts;