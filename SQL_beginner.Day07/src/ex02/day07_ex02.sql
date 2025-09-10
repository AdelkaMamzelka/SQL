(SELECT PZR.name, count(*) as count, 'order' as action_type
FROM person_order PO
JOIN menu M
    ON PO.menu_id = M.id
JOIN pizzeria PZR
    ON M.pizzeria_id = PZR.id
GROUP BY PZR.name
ORDER BY count DESC LIMIT 3
)
UNION
(SELECT PZR.name, count(*) as count, 'visit' as action_type
FROM person_visits PV
JOIN pizzeria PZR
    ON PV.pizzeria_id = PZR.id
GROUP BY PZR.name
ORDER BY count DESC
LIMIT 3)
ORDER BY action_type, count DESC;