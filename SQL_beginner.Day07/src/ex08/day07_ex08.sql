SELECT address, PZR.name, count(*) count_of_orders
FROM person P
    JOIN person_order PO
        ON PO.person_id = p.id
    JOIN menu M 
        ON PO.menu_id = M.id
    JOIN pizzeria PZR 
        ON PZR.id = M.pizzeria_id
GROUP BY P.address, PZR.name
ORDER BY 1, 2;