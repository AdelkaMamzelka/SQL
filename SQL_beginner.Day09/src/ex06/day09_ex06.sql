CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
    IN pperson varchar='Dmitriy', 
    pprice int= 500,
    pdate date= '2022-01-08')
RETURNS TABLE (
        pizzeria_name varchar
) AS $$
        (SELECT DISTINCT pizzeria FROM person_visits
        JOIN person on person.id = person_visits.person_id 
        JOIN pizzeria on pizzeria.id = person_visits.pizzeria_id
        JOIN menu on menu.pizzeria_id = pizzeria.id
        WHERE person.name = pperson AND person_visits.visit_date = pdate AND menu.price < pprice);
$$ LANGUAGE sql;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');