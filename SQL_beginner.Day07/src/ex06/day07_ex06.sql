SELECT pizzeria.name, 
    COUNT(*) AS count_of_orders, 
    ROUND(AVG(M.price), 2) AS average_price, 
    MAX(M.price) AS max_price, 
    MIN(M.price) AS min_price
FROM menu M
    JOIN person_order ON M.id = person_order.menu_id
    JOIN pizzeria ON M.pizzeria_id = pizzeria.id
GROUP BY pizzeria.name
ORDER BY name;