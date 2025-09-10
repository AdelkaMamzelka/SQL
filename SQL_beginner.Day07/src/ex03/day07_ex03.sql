WITH selected_orders AS
        (SELECT pizzeria.name, count(*) count, 'order' as action_type
        FROM person_order
            JOIN menu ON menu.id=person_order.menu_id
            JOIN pizzeria on pizzeria.id=menu.pizzeria_id
        GROUP BY pizzeria.name
        ORDER BY count DESC, pizzeria.name),
    selected_visits AS
        (SELECT pizzeria.name, count(*) count, 'visit' as action_type
        FROM person_visits
            JOIN pizzeria on pizzeria.id=person_visits.pizzeria_id
        GROUP BY pizzeria.name
        ORDER BY count DESC, pizzeria.name)
SELECT selected_orders.name, (selected_orders.count + selected_visits.count) as total_count 
FROM selected_orders
    JOIN selected_visits ON selected_orders.name=selected_visits.name
ORDER BY total_count DESC, name ASC;