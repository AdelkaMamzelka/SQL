COMMENT ON TABLE person_discounts IS 'Таблица со скидками и айдишками.';
COMMENT ON COLUMN person_discounts.person_id IS 'Айди клиентов, которые делают заказ';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Айди пиццерий, в которых делаются заказы';
COMMENT ON COLUMN person_discounts.discount IS 'Размер скидки в процентах';

-- SELECT count(*) = 4 as check
--       FROM   pg_description
--       WHERE  objoid = 'person_discounts'::regclass 