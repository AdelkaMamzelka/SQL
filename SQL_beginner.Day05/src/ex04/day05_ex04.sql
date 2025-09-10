CREATE UNIQUE INDEX if not exists idx_menu_unique ON menu(pizzeria_id, pizza_name);
-- DROP INDEX idx_menu_unique;

SET enable_seqscan TO OFF;
EXPLAIN ANALYZE
    SELECT pizzeria_id, pizza_name
    FROM menu
        WHERE pizzeria_id = 1 AND pizza_name = 'cheese pizza';