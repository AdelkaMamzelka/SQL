SELECT
    COALESCE(person.name, '-'),
    visit_date,
    COALESCE(pizzeria.name, '-') AS pizzeria_name
FROM
    (SELECT * 
    FROM person_visits 
    WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03') AS dvisit
FULL JOIN pizzeria ON dvisit.pizzeria_id = pizzeria.id
FULL JOIN person ON dvisit.person_id = person.id
ORDER BY 1, 2, 3;

-- coalesce возвращает первый из параметров, имеющий допустимое представление non-NULL