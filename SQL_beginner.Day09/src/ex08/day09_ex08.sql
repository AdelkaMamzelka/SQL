CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop int default 10)
RETURNS TABLE(num int) AS $$
    with recursive cte_fibonacci(num1, num2) AS (
        values(0,1) 
        union all
            SELECT 
            GREATEST(num1, num2), num1 + num2
        FROM cte_fibonacci
            WHERE num2 < pstop)
    SELECT num1 FROM cte_fibonacci;
$$ LANGUAGE sql;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();